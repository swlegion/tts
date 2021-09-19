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

// Validate that the contrib files are valid.
const isWindows = process.platform === 'win32';

runTool(
  `ajv${isWindows ? '.cmd' : ''}`,
  '-d "./contrib/cards.json"',
  '-s "./mod/schema/CardSet.json"',
  '-r "./mod/schema/deps/**.json"',
  '--strict',
  '--errors=line',
  '--changes=line',
);
