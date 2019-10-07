import fs from 'fs-extra';
import luaFmt from 'lua-fmt';
import path from 'path';
import xmlFmt from 'xml-formatter';

/*
 * Extraction; based off https://github.com/KarateSnoopy/TTSLuaExtractor.
 */
(() => {
  "use strict";
})();

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
    const output = {...data};
    delete output.ObjectStates;
    delete output.LuaScript;
    delete output.LuaScriptState;
    delete output.XmlUI;

    fs.outputJSONSync(path.join(to, 'global.json'), output, {spaces: 2});
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
      fs.outputFileSync(path.join(to, `${name}.lua`), luaFmt.formatText(data.LuaScript));
    }

    if (data.LuaScriptState.length > 0) {
      fs.outputJSONSync(path.join(to, `${name}.state.json`), JSON.parse(data.LuaScriptState), {spaces: 2});
    }

    if (data.XmlUI.length > 0) {
      fs.outputFileSync(path.join(to, `${name}.xml`), xmlFmt(data.XmlUI));
    }
  }

  /**
   * Recursively output metadata for objects inside the mod.
   *
   * @param to 
   * @param data 
   */
  private extractObject(to: string, data: TTSObject, name = ''): void {
    const output = {...data};
    delete output.ContainedObjects;
    delete output.LuaScript;
    delete output.LuaScriptState;
    delete output.States;
    delete output.XmlUI;

    if (name !== '') {
      name = data.Nickname;
    }
    if (name === '') {
      name = data.Name;
    }
    if (name === '') {
      name = data.GUID;
    } else {
      name = `${name}.${data.GUID}`;
    }

    fs.outputJSONSync(path.join(to, `${name}.json`), output, {spaces: 2});
    this.extractCommon(name, to, data);

    if (data.ContainedObjects && data.ContainedObjects.length > 0) {
      const children = path.join(to, 'objects');
      for (const child of data.ContainedObjects) {
        this.extractObject(children, child);
      }
    }

    if (data.States) {
      const children = path.join(to, 'states');
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
    this.readSaveFile(fs.readFileSync(path, { encoding: 'UTF-8' }));
  }

  /**
   * Reads a save file from JSON.
   *
   * @param json
   */
  public readSaveJson(json: string): void {
    this.data = JSON.parse(json);
  }
}
