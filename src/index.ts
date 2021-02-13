import * as expander from '@matanlurey/tts-expander';
import * as steam from '@matanlurey/tts-runner/steam_finder';
import fs from 'fs-extra';
import os from 'os';
import path from 'path';

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
    console.info(`Clearing output directory "${output}"`);
    await fs.remove(output);
    await fs.mkdirp(output);
  }
  const splitter = new expander.SplitIO();
  const modTree = await splitter.readSaveAndSplit(source);
  await splitter.writeSplit(output, modTree);
  console.info(`Wrote "${output}"...`);
}

export async function compileSaveFile(
  source: string,
  output: string,
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
  console.info(`Reading "${source}"...`);
  const splitter = new expander.SplitIO();
  const saveFile = await splitter.readAndCollapse(source);
  console.info(`Writing "${output}"...`);
  await fs.writeJson(output, saveFile);
  console.info(`Wrote "${output}"...`);
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
