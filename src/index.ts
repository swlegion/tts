import TTS, { OutgoingJsonObject } from '@matanlurey/tts-editor';
import * as expander from '@matanlurey/tts-expander';
import * as steam from '@matanlurey/tts-runner/steam_finder';
import { ObjectState } from '@matanlurey/tts-save-files';
import fs from 'fs-extra';
import os from 'os';
import path from 'path';
import buildDeckSchemaLua from './lib/generate-deck-schema';

/**
 * Reads a `{TTS-SAVE-FILE}.json`, and replaces the contents of a directory.
 */
export async function extractSaveFile(
  source: string,
  output: string,
): Promise<void> {
  if (!fs.pathExists(source)) {
    throw new Error(`No source file "${source}".`);
  }
  if (!fs.pathExists(output)) {
    console.info(`Creating output directory "${output}"`);
    await fs.mkdirp(output);
  } else {
    const baseName = path.basename(source).split('.')[0];
    const modOutput = path.join(output, baseName);
    console.info(`Clearing output directory "${modOutput}"`);
    await fs.remove(modOutput);
    await fs.mkdirp(modOutput);
    console.info(`Cleared "${modOutput}"`);
  }
  const splitter = new expander.SplitIO();
  const modTree = await splitter.readSaveAndSplit(source);
  await splitter.writeSplit(output, modTree);
  console.info(`Wrote "${output}"...`);
}

function concatAllObjectScripts(
  states: ObjectState[],
  buffer?: OutgoingJsonObject[],
): OutgoingJsonObject[] {
  const writeBuffer = buffer || [];
  states.forEach((state) => {
    const { GUID } = state;
    if (!GUID) {
      return;
    }
    writeBuffer.push({
      guid: GUID,
      script: state.LuaScript,
      ui: state.XmlUI,
    });
    if (state.ContainedObjects) {
      concatAllObjectScripts(state.ContainedObjects, writeBuffer);
    }
  });
  return writeBuffer;
}

export async function compileSaveFile(
  source: string,
  output: string,
  options?: { reload: boolean },
): Promise<void> {
  if (!fs.pathExists(source)) {
    throw new Error(`No source directory "${source}".`);
  }
  const outputDir = path.dirname(output);
  if (!fs.pathExists(outputDir)) {
    console.info(`Creating output directory "${outputDir}"`);
    await fs.mkdirp(outputDir);
  } else {
    console.info(`Clearing output directory "${outputDir}"`);
    await fs.remove(outputDir);
    await fs.mkdirp(outputDir);
  }
  await generateFiles();
  await buildDeckSchemaLua(
    path.join('contrib', 'cards', 'official.json'),
    path.join('mod', 'src', 'includes', 'generated', 'cards.ttslua'),
  );
  console.info(`Reading "${source}"...`);
  const splitter = new expander.SplitIO();
  const saveFile = await splitter.readAndCollapse(source);
  console.info(`Writing "${output}"...`);
  await fs.writeJson(output, saveFile);
  console.info(`Wrote "${output}"...`);
  if (options?.reload) {
    const api = new TTS();
    const json: OutgoingJsonObject[] = [
      {
        guid: '-1',
        script: saveFile.LuaScript,
        ui: saveFile.XmlUI,
      },
      ...concatAllObjectScripts(saveFile.ObjectStates),
    ];
    try {
      await api.saveAndPlay(json);
      console.info(`Sent reload command!`);
    } catch (e) {
      console.warn(`Could not reload. Is TTS currently running?`, e);
    }
  }
}

export async function destroySymlink(homeDir?: string): Promise<void> {
  // TODO: Add non-win32 support.
  if (!homeDir) {
    if (os.platform() !== 'win32') {
      throw new Error(`Unsupported platform: ${os.platform()}`);
    }
    homeDir = steam.homeDir.win32(process.env);
  }
  const from = path.join(homeDir, 'Saves', 'TTSDevLink');
  return fs.remove(from);
}

export async function createSymlink(homeDir?: string): Promise<string> {
  // TODO: Add non-win32 support.
  if (!homeDir) {
    if (os.platform() !== 'win32') {
      throw new Error(`Unsupported platform: ${os.platform()}`);
    }
    homeDir = steam.homeDir.win32(process.env);
  }
  await destroySymlink(homeDir);
  const from = path.join(homeDir, 'Saves', 'TTSDevLink');
  await fs.symlink(
    path.resolve('dist'),
    from,
    os.platform() === 'win32' ? 'junction' : 'dir',
  );
  return from;
}

export async function generateFiles(): Promise<void> {
  console.info(`Generating additional files...`);
  await buildDeckSchemaLua(
    path.join('contrib', 'cards', 'official.json'),
    path.join('mod', 'src', 'includes', 'generated', 'cards.ttslua'),
  );
}
