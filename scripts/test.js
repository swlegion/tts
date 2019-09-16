const fs = require('fs');
const path = require('path');

const userTempDirectory = require('temp-dir');
const tableTopSimulator = path.join(userTempDirectory, 'TabletopSimulator', 'Tabletop Simulator Lua');

console.log('Checking', tableTopSimulator);

if (fs.existsSync(tableTopSimulator)) {
  console.log('Success!');
} else {
  console.error('Could not find directory. Is Atom running with the Table Top Simulator plugin?', 'https://github.com/swlegion/tts/wiki/Editing-the-Mod');
}
