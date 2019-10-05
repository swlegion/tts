import detectNewline from 'detect-newline';
import fs from 'fs-extra';

const text = fs.readFileSync('mod\\src\\black_attack_dice_blue.758849.lua', {encoding: 'UTF-8'});
console.log(
  `"${detectNewline.graceful(text) == '\n' ? '\\n' : '\\r\\n'}"`
);