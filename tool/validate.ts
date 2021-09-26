import fs from 'fs-extra';
import path from 'path';
import { exec, exit } from 'shelljs';

/**
 * Executes a tool on the command-line.
 *
 * @param name
 * @param args
 */
function runTool(name: string, ...args: string[]): void {
  console.log(`\nEXEC: ${name}`);
  console.log(...args);
  const result = exec(`${name} ${args.join(' ')}`);
  if (result.code !== 0) {
    console.error(`FAIL: ${name}`, args);
    exit(1);
  } else {
    console.log(`DONE: ${name}`);
  }
}

const isWindows = process.platform === 'win32';

// Validate that the contrib files are valid.
(() => {
  runTool(
    `ajv${isWindows ? '.cmd' : ''}`,
    '-d "./contrib/cards.json"',
    '-s "./mod/schema/CardSet.json"',
    // https://github.com/ajv-validator/ajv-cli/issues/172
    '-r "./mod/schema/deps/**.json"',
    '--strict',
    '--errors=line',
    '--changes=line',
  );
})();

// Validate that the save file(s) are valid.
(() => {
  // https://github.com/ajv-validator/ajv-cli/issues/172
  const saveFormatDir = './node_modules/@matanlurey/tts-save-format/src/schema';
  const recursiveDeps = fs
    .readdirSync(saveFormatDir)
    .filter((f) => f.endsWith('.json') && path.basename(f) !== 'SaveState.json')
    .map((f) => `-r "${saveFormatDir}/${f}"`);

  runTool(
    `ajv${isWindows ? '.cmd' : ''}`,
    '-d "./dist/StarWarsLegion.json"',
    '-s "./node_modules/@matanlurey/tts-save-format/src/schema/SaveState.json"',
    ...recursiveDeps,
    '--strict-required=false',
    '--strict-schema=false',
    '--remove-additional=failing',
    '--errors=line',
    '--changes=line',
  );
})();
