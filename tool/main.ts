import minimist from 'minimist';
import { exit } from 'shelljs';
import { compileSaveFile, createSymlink, extractSaveFile } from '../src';

// Changes the default behavior of unhandled promises.
require('make-promises-safe');

(async () => {
  const args = minimist(process.argv.slice(2));
  const positional = args._;
  switch (positional[0]) {
    case 'compile':
      console.info(`Compiling "${positional[1]}" -> "${positional[2]}"...`);
      await compileSaveFile(positional[1], positional[2]);
      break;
    case 'extract':
      console.info(`Extracting "${positional[1]}" -> "${positional[2]}"`);
      await extractSaveFile(positional[1], positional[2]);
      break;
    case 'develop':
      console.info(`Compiling "${positional[1]}" -> "${positional[2]}"...`);
      await compileSaveFile(positional[1], positional[2]);
      const symLink = await createSymlink();
      console.info(`Created "${symLink}" -> "${positional[2]}"`);
      break;
    default:
      console.error('Unknown command', args);
      exit(1);
  }
})();
