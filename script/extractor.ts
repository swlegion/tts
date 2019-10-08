#!/usr/bin/env node

import clear from "clear";
import chalk from "chalk";
import figlet from "figlet";
import fs from "fs-extra";
import luaFmt from "lua-fmt";
import path from "path";
import program from "commander";
import sanitize from "sanitize-filename";
import xmlFmt from "xml-formatter";

class Extractor {
  /**
   * Data that is being read/written.
   */
  private data: TTSMod;

  /**
   * Writes an extracted mapped path to disk.
   *
   * ```
   * mod/
   *   global/
   *     data.json   // object
   *     state.json  // object.LuaScriptState
   *     script.lua  // object.LuaScript
   *     ui.xml      // object.XmlUI
   * ```
   *
   * @param to
   */
  public extract(to: string): void {
    // Delete the folder.
    fs.removeSync(to);

    // Extract global script.
    this.extractGlobal(to);

    // Extract individual objects.
    for (const child of this.data.ObjectStates) {
      this.extractObject(path.join(to, 'objects'), child);
    }
  }

  /**
   * Output metadata for the global object.
   *
   * @param to
   */
  private extractGlobal(to: string): void {
    const data = this.data;
    const output = { ...data };
    delete output.ObjectStates;
    delete output.LuaScript;
    delete output.LuaScriptState;
    delete output.XmlUI;

    fs.outputJSONSync(path.join(to, 'global.json'), output, { spaces: 2 });
    this.extractCommon('global', to, data);
  }

  /**
   * Output metadata that is common to all objects.
   *
   * @param name
   * @param to
   * @param data
   */
  private extractCommon(name: string, to: string, data: TTSBase): void {
    if (data.LuaScript.length > 0) {
      fs.outputFileSync(path.join(to, `script.lua`), data.LuaScript);
    }

    if (data.LuaScriptState.length > 0) {
      fs.outputJSONSync(
        path.join(to, `state.json`),
        JSON.parse(data.LuaScriptState),
        { spaces: 2 }
      );
    }

    if (data.XmlUI.length > 0) {
      fs.outputFileSync(path.join(to, `ui.xml`), xmlFmt(data.XmlUI));
    }
  }

  /**
   * Recursively output metadata for objects inside the mod.
   *
   * @param to
   * @param data
   */
  private extractObject(to: string, data: TTSObject, name = ""): void {
    const output = { ...data };
    delete output.ContainedObjects;
    delete output.Description;
    delete output.LuaScript;
    delete output.LuaScriptState;
    delete output.States;
    delete output.XmlUI;

    if (name.trim().length === 0) {
      name = data.Nickname;
    }
    if (name.trim().length === 0) {
      name = data.Name;
    }
    if (name.trim().length === 0) {
      name = data.GUID;
    } else {
      name = `${name}.${data.GUID}`;
    }

    // Normalize the name.
    name = sanitize(name.toLowerCase())
      .trim()
      .replace(/ /g, "_");

    // Add then name to the output directory.
    to = path.join(to, name);

    fs.outputJSONSync(path.join(to, `data.json`), output, { spaces: 2 });
    fs.outputFileSync(path.join(to, `description.txt`), data.Description);

    if (data.Description.length > 0) {
      this.extractCommon(name, to, data);
    }

    if (data.ContainedObjects && data.ContainedObjects.length > 0) {
      const children = path.join(to, "objects");
      for (const child of data.ContainedObjects) {
        this.extractObject(children, child);
      }
    }

    if (data.States) {
      const children = path.join(to, "states");
      for (const state in data.States) {
        const child = data.States[state];
        this.extractObject(children, child, state);
      }
    }
  }

  /**
   * Reads a save file from disk.
   *
   * @param path
   */
  public readSaveFile(path: string): void {
    this.data = fs.readJSONSync(path);
  }
}

/*
 * Extraction; based off https://github.com/KarateSnoopy/TTSLuaExtractor.
 */
(() => {
  "use strict";

  // Starts the terminal with a cleared terminal.
  clear();

  console.log(
    chalk.magenta(figlet.textSync("TTS", { horizontalLayout: "full" }))
  );

  program
    .command("extract <source> <destination>")
    .description("Extracts LUA scripts")
    .action((source: string, destination: string) => {
      if (!fs.existsSync(source)) {
        console.error(chalk.red(`Could not find a file at ${source}.`));
        process.exit(1);
      }

      const extractor = new Extractor();
      console.log(`Reading ${source}...`);
      extractor.readSaveFile(source);

      console.log(`Writing to ${destination}`);
      extractor.extract(destination);
    });

  program.description("A CLI for developing with TTS").parse(process.argv);
})();

interface TTSBase {
  /**
   * Contains a `.ttslua` script for this entity.
   *
   * May be empty (`''`) if there is no associated script.
   */
  LuaScript: string;

  /**
   * Serialized (as JSON) intermediate state of the running script.
   */
  LuaScriptState: string;

  /**
   * Contains the XML layout user interface for this entity.
   *
   * May be empty (`''`) if there is no associated XML.
   */
  XmlUI: string;
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
   * Description of the object.
   */
  Description: string;

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

  /**
   * Alternative states for this object.
   */
  States: { [index: string]: TTSObject } | undefined;
}
