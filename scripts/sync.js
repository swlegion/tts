const path = require('path');
const TreeSync = require('tree-sync');

const userTempDirectory = require('temp-dir');
const tableTopSimulator = path.join(userTempDirectory, 'TabletopSimulator', 'Tabletop Simulator Lua');
const sourceDirectory = path.join('./', 'src', 'lua');

const mode = process.argv[2];

let input;
let output;

if (mode == 'read') {
  input = tableTopSimulator;
  output = sourceDirectory;
} else {
  input = sourceDirectory;
  output = tableTopSimulator;
}

new TreeSync(input, output).sync();
