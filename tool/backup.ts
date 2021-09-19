import { ObjectState } from '@matanlurey/tts-save-files';
import fs from 'fs-extra';
import isPng from 'is-png';
import minimist from 'minimist';
import fetch from 'node-fetch';
import path from 'path';

// Changes the default behavior of unhandled promises.
require('make-promises-safe');

const findMiniInfo = /miniInfo\.(\S+)/g;
const findMeshUrl = /mesh\s*=\s*\"(.*)\"/;
const findDiffuseUrl = /diffuse\s*=\s*\"(.*)\"/;
const findAssetBundleUrl = /assetbundle\s*=\s*\"(.*)\"/;

type MiniInfo = { assetBundle: string } | { mesh: string; diffuse?: string };

function dirtyParseMiniInfo(region: string): MiniInfo | undefined {
  if (region.indexOf('assetbundle') === -1) {
    const mesh = findMeshUrl.exec(region)?.[1];
    const diffuse = findDiffuseUrl.exec(region)?.[1];
    if (mesh) {
      return { mesh, diffuse };
    }
  } else {
    const assetBundle = findAssetBundleUrl.exec(region)?.[1];
    if (assetBundle) {
      return { assetBundle };
    }
  }
}

/**
 * Writes a file to disk for each parsed asset.
 *
 * Returns the total number of assets backed up.
 *
 * @param writeFile Function that will write a file to disk.
 * @param readUrl Function that will read a URL from the network.
 * @param inputContents File contents to parse and execute backup.
 */
async function backupMiniAssets(
  writeFile: (name: string, data: Uint8Array) => Promise<void>,
  readUrl: (url: string) => Promise<{ url: string; data: Uint8Array }>,
  inputContents: string,
): Promise<number> {
  let count = 0;
  for (const match of Array.from(inputContents.matchAll(findMiniInfo))) {
    if (!match.index) {
      continue;
    }
    count++;
    const name = match[1];

    // Find the next mesh = "URL" and diffuse = "URL" before the "}"
    const region = inputContents.substring(
      match.index,
      inputContents.indexOf('}', match.index),
    );

    const parsed = dirtyParseMiniInfo(region);
    if (!parsed) {
      continue;
    }

    console.log(`Fetching mini#${count}: \"${name}\"...`, parsed, '\n');

    const promises: Promise<void>[] = [];
    if ('assetBundle' in parsed) {
      promises.push(
        writeFile(`${name}.unity3d`, (await readUrl(parsed.assetBundle)).data),
      );
    } else {
      promises.push(
        writeFile(`${name}.obj`, (await readUrl(parsed.mesh)).data),
      );
      if (parsed.diffuse) {
        promises.push(
          readUrl(parsed.diffuse).then((data) => {
            const extension = isPng(data.data) ? 'png' : 'jpg';
            return writeFile(`${name}.${extension}`, data.data);
          }),
        );
      }
    }

    await Promise.all(promises);
  }
  return count;
}

async function backupCardAssets(
  writeFile: (name: string, data: Uint8Array) => Promise<void>,
  readUrl: (url: string) => Promise<{ url: string; data: Uint8Array }>,
  cardDir: string,
  cardFiles: string[],
) {
  // Step 1: Make a Set (uniqueness) of all card assets.
  const assets = new Set<string>();
  for (const cardFile of cardFiles) {
    const cardPath = path.join(cardDir, cardFile);
    const cardJson = (await fs.readJson(cardPath)).Object as ObjectState;
    if (cardJson.CustomDeck) {
      for (const key in cardJson.CustomDeck) {
        const deck = cardJson.CustomDeck[key];
        assets.add(deck.FaceURL);
        assets.add(deck.BackURL);
      }
    }
  }

  // Step 2: Download.
  console.log(
    `Downloading ${assets.size} assets from ${cardFiles.length} cards.`,
  );
  const files = new Set<string>();
  for (const cardAsset of Array.from(assets)) {
    const file = await readUrl(cardAsset);
    const name = path.basename(file.url);
    if (files.has(name)) {
      console.warn(`Ignoring "${name}" (duplicate filename)`);
    } else {
      files.add(name);
      await writeFile(name, file.data);
    }
  }
}

(async () => {
  async function readUrl(
    url: string,
  ): Promise<{ url: string; data: Uint8Array }> {
    const response = await fetch(url);
    const data = new Uint8Array(await response.arrayBuffer());
    let name = response.url;
    if (response.headers.get('Content-Disposition')) {
      const header = response.headers.get('Content-Disposition');
      if (header) {
        const fileName = /filename=\"\w+\_(.*)\"/.exec(header)?.[1];
        if (fileName) {
          name = fileName;
        }
      }
    }
    return { url: name, data };
  }

  const args = minimist(process.argv.slice(2));
  const input = args['input'] as string | undefined;
  const output = args['output'];
  const parse = !!args['parse-only'];

  if (!input) {
    console.error('No --input file or directory specified.');
    return;
  }

  if (!output && !parse) {
    console.error('No --output directory specified.');
    return;
  }

  async function fakeWriteFile(name: string, data: Uint8Array): Promise<void> {
    console.log(`Would write ${data.byteLength} bytes as "${name}"`);
  }
  async function realWriteFile(name: string, data: Uint8Array): Promise<void> {
    await fs.writeFile(`${path.join(output, name)}`, data);
  }

  const writeFile = parse ? fakeWriteFile : realWriteFile;

  if (input.endsWith('.ttslua')) {
    await backupMiniAssets(
      writeFile,
      readUrl,
      await fs.readFile(input, 'utf-8'),
    );
  } else {
    await backupCardAssets(writeFile, readUrl, input, await fs.readdir(input));
  }
})();
