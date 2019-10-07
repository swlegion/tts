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
  States: {[index: string] : TTSObject} | undefined;
}
