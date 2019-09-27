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
    .command('develop <source> <destination>')
    .description('Extracts and Embeds LUA scripts')
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

      writeLua(parsed, path.join('mod', 'src'), '~GLOBAL');
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
function normalize(name: string): string {
  name = name.toLowerCase().trim();
  name = name.replace(' ', '_');
  return sanitize(name);
}

/**
 * Writes a LuaScript to disk.
 *
 * @param object 
 * @param output 
 */
function writeLua(object: TTSMod | TTSObject, output: string, name?: string): void {
  if (!name) {
    if ('Nickname' in object && object.Nickname !== "") {
      name = object.Nickname;
    } else if ('Name' in object) {
      name = object.Name;
    }
  }
  if (!name || !output) {
    console.warn(
      chalk.yellow(`Could not parse Lua: name=${name}, output=${output}`)
    );
    return;
  }
  name = normalize(name);
  let file = path.join(output, name);
  if ('GUID' in object) {
    file = `${file}.${object.GUID}`;
  }
  file = `${file}.lua`;
  if (object.LuaScript !== '') {
    fs.mkdirpSync(path.dirname(file));
    fs.writeFileSync(file, object.LuaScript);
  }
  if ('ObjectStates' in object && object.ObjectStates.length > 0) {
    for (const child of object.ObjectStates) {
      writeLua(child, output);
    }
  }
  if ('ContainedObjects' in object && object.ContainedObjects.length > 0) {
    const newDir = path.join(output, `${name}.${object.GUID}`);
    for (const child of object.ContainedObjects) {
      writeLua(child, newDir);
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
