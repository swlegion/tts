#!/usr/bin/env node

import clear from 'clear';
import chalk from 'chalk';
import figlet from 'figlet';
import fs from 'fs-extra';
import path from 'path';
import program from 'commander';
import sanitize from 'sanitize-filename';

/*
 * Extraction; based off https://github.com/KarateSnoopy/TTSLuaExtractor.
 */
(() => {
  'use strict';

  // Starts the terminal with a cleared terminal.
  clear();

  console.log(
    chalk.magenta(
      figlet.textSync('TTS', {horizontalLayout: 'full'})
    )
  );
  
  program
    .command('extract <source> <destination>')
    .description('Extracts LUA scripts')
    .action((source: string, destination: string) => {
      if (!fs.existsSync(source)) {
        console.error(chalk.red(`Could not find a file at ${source}.`));
        process.exit(1);
      }

      fs.removeSync(destination);
      fs.mkdirpSync(destination);

      console.log(`Loading ${source}...`);
      const parsed = loadMod(fs.readFileSync(source, {
        encoding: 'UTF-8',
      }));

      extractLua(parsed, path.join('mod', 'src'), '~GLOBAL');
    });
  
  program
    .command('embed <source> <destination>')
    .description('Embeds LUA scripts')
    .action((source: string, destination: string) => {
      if (!fs.existsSync(source)) {
        console.error(chalk.red(`Could not find a directory at ${source}.`));
        process.exit(1);
      }
      if (!fs.existsSync(destination)) {
        console.error(chalk.red(`Could not find a file at ${source}.`));
        process.exit(1);
      }

      console.log(`Loading ${destination}...`);
      const parsed = loadMod(fs.readFileSync(destination, {
        encoding: 'UTF-8',
      }));

      embedLua(parsed, path.join('mod', 'src'), '~GLOBAL');

      fs.writeFileSync(destination, JSON.stringify(parsed, null, 2));
    });

  program
    .description('A CLI for developing with TTS')
    .parse(process.argv);
})();

/**
 * Loads a TTS Mod/Save file as a typed JSON structure.
 *
 * @param contents 
 */
function loadMod(contents: string): TTSMod {
  return JSON.parse(contents) as TTSMod;
}

/**
 * Normalize a name to something fine for a name on disk.
 * 
 * @param name
 */
function normalizeName(name: string): string {
  name = name.toLowerCase().trim();
  name = name.replace(' ', '_');
  return sanitize(name);
}

/**
 * Attempts to find the "best" name for an object.
 * 
 * @param name 
 * @param object 
 */
function findBestName(name: string | undefined, object: TTSMod | TTSObject) : string {
  if (name && name.trim().length > 0) {
    return name;
  }
  if ('Nickname' in object) {
    return object.Nickname || object.Name;
  }
  throw `Could not determine name!\n\n${JSON.stringify(object)}`;
}

/**
 * Finds the path for an object to be serialized/deserialized from disk.
 * 
 * @param source
 * @param name 
 * @param object 
 */
function findFilePath(source: string, name: string, object: TTSMod | TTSObject) : string {
  let file = path.join(source, name);
  if ('GUID' in object) {
    file = `${file}.${object.GUID}`;
  }
  return `${file}.lua`;
}

/**
 * Returns whether the provided script is valuable to retain on disk.
 *
 * @param name 
 */
function isValuableLuaScript(script: string): boolean {
  // Ignore empty script.
  if (script === "") {
    return false;
  }

  const lines = script.split('\n');

  // Ignore scripts that just set positions/rotations/tint.
  //
  // We can always tweak this.
  if (lines.length < 50) {
    if (lines[0].startsWith('position =') || lines[0].startsWith('battlefieldTint =')) {
      return false;
    }
  }
  
  // OK.
  return true;
}

/**
 * Writes a LuaScript to disk.
 *
 * @param object 
 * @param output 
 */
function extractLua(object: TTSMod | TTSObject, output: string, name?: string): void {
  name = normalizeName(findBestName(name, object));
  const file = findFilePath(output, name, object);
  const script = object.LuaScript;
  if (isValuableLuaScript(script)) {
    fs.mkdirpSync(path.dirname(file));
    fs.writeFileSync(file, object.LuaScript);
  }
  if ('ObjectStates' in object && object.ObjectStates.length > 0) {
    for (const child of object.ObjectStates) {
      extractLua(child, output);
    }
  }
  if ('ContainedObjects' in object && object.ContainedObjects.length > 0) {
    const newDir = path.join(output, `${name}.${object.GUID}`);
    for (const child of object.ContainedObjects) {
      extractLua(child, newDir);
    }
  }
}

/**
 * Embeds LuaScript into memory.
 * 
 * @param object 
 * @param input 
 * @param name 
 */
function embedLua(object: TTSMod | TTSObject, input: string, name?: string): void {
  name = normalizeName(findBestName(name, object));
  const file = findFilePath(input, name, object);
  if (fs.existsSync(file)) {
    object.LuaScript = fs.readFileSync(file, {encoding: 'UTF-8'});
  }
  if ('ObjectStates' in object && object.ObjectStates.length > 0) {
    for (const child of object.ObjectStates) {
      embedLua(child, input);
    }
  }
  if ('ContainedObjects' in object && object.ContainedObjects.length > 0) {
    const newDir = path.join(input, `${name}.${object.GUID}`);
    for (const child of object.ContainedObjects) {
      embedLua(child, newDir);
    }
  }
}

interface TTSBase {
  /**
   * Contains a `.ttslua` script for this entity.
   */
  LuaScript: string;
}

interface TTSMod extends TTSBase {
  /**
   * Date that the save file/mod was last touched by TTS.
   */
  Date: string;

  /**
   * Objects contained in the mod.
   */
  ObjectStates: TTSObject[];

  /**
   * Version of either the mod or save file, unsure.
   */
  VersionNumber: string;
}

interface TTSObject extends TTSBase {
  /**
   * If this object can contain other objects, an array of those objects.
   */
  ContainedObjects: TTSObject[] | undefined;
  
  /**
   * Name of the object.
   */
  Name: string;

  /**
   * A custom name of the object.
   */
  Nickname: string;

  /**
   * Unique ID of the object.
   */
  GUID: string;
}
