import fs from 'fs-extra';
import isPng from 'is-png';
import minimist from 'minimist';
import fetch from 'node-fetch';

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
  readUrl: (url: string) => Promise<Uint8Array>,
  inputContents: string,
): Promise<number> {
  let count = 0;
  for (const match of Array.from(inputContents.matchAll(findMiniInfo))) {
    count++;
    const name = match[1];

    // Find the next mesh = "URL" and diffuse = "URL" before the "}"
    const region = inputContents.substring(
      match.index!,
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
        writeFile(`${name}.unity3d`, await readUrl(parsed.assetBundle)),
      );
    } else {
      promises.push(writeFile(`${name}.obj`, await readUrl(parsed.mesh)));
      if (parsed.diffuse) {
        promises.push(
          readUrl(parsed.diffuse).then((data) => {
            const extension = isPng(data) ? 'png' : 'jpg';
            return writeFile(`${name}.${extension}`, data);
          }),
        );
      }
    }

    await Promise.all(promises);
  }
  return count;
}

(async () => {
  async function readUrl(url: string): Promise<Uint8Array> {
    const response = await fetch(url);
    return new Uint8Array(await response.arrayBuffer());
  }
  async function nullWriteFile(name: string, data: Uint8Array): Promise<void> {
    console.log(`Would write ${data.byteLength} bytes as "${name}"`);
  }
  const args = minimist(process.argv.slice(2));
  const input = args['input'];
  const output = args['output'];
  const parse = !!args['parse-only'];
  if (!input) {
    console.error('No --input file specified.');
    return;
  }
  if (!output) {
    console.error('No --output directory specified.');
    return;
  }
  const writeFile = parse ? nullWriteFile : fs.writeFile;
  await backupMiniAssets(writeFile, readUrl, await fs.readFile(input, 'utf-8'));
})();
