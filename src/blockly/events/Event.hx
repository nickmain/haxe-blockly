package blockly.events;

import js.html.Element;

/** Typed events */
enum Event {
    Change (event: Change);
    Create (event: Create);
    Delete (event: Delete);
    Move   (event: Move);
    UI     (event: UI);
    Unknown(event: Abstract);
}

abstract BlocklyEvent(Abstract) {
    inline public function new(event: Abstract) this = event;

    @:to public function toEvent(): Event {
        if(this.type == EventType.CHANGE) return Change(cast this);
        if(this.type == EventType.CREATE) return Create(cast this);
        if(this.type == EventType.DELETE) return Delete(cast this);
        if(this.type == EventType.MOVE  ) return Move(cast this);
        if(this.type == EventType.UI    ) return UI(cast this);
        return Unknown(this);
    }
}

/** Base for event types */
@:native("Blockly.Events.Abstract")
extern class Abstract {
    var type (default,null): String;  //see EventType
    var blockId (default,null): String;
    var workspaceId (default,null): String;
    var recordUndo (default,null): Bool; //whether event registers in the undo manager
}

@:native("Blockly.Events")
extern class EventType {
    static var CREATE (default,null): String;
    static var DELETE (default,null): String;
    static var CHANGE (default,null): String;
    static var MOVE   (default,null): String;
    static var UI     (default,null): String;
}

/** Change event */
@:native("Blockly.Events.Change")
extern class Change extends Abstract {
    var element  (default,null): String;       // name of element that changed: 'field', 'comment', 'disabled', etc.
    var name     (default,null): Null<String>; // name of field or input that changed - or null
    var oldValue (default,null): String;       // previous value of element
    var newValue (default,null): String;       // new value of element
}

/** Some possible Change event element types */
class ChangeElement {
    public static var Field (default,null) = "field";
    public static var Comment (default,null) = "comment";
    public static var Disabled (default,null) = "disabled";

    // TODO: others exist but are not documented
}

/** Create event */
@:native("Blockly.Events.Create")
extern class Create extends Abstract {
    var xml (default,null): Element;       // XML serialization of the new block
    var ids (default,null): Array<String>; // ids of the block and all its descendants
}

/** Delete event */
@:native("Blockly.Events.Delete")
extern class Delete extends Abstract {
    var oldXml (default,null): Element;       // XML serialization of the deleted block
    var ids    (default,null): Array<String>; // ids of the block and all its descendants
}

/** Move event */
@:native("Blockly.Events.Move")
extern class Move extends Abstract {
    var oldParentId   (default,null): Null<String>;  // if was connected to an input
    var oldInputName  (default,null): Null<String>;  // if was connected to an input
    var oldCoordinate (default,null): Null<{x:Int, y: Int}>;  // if was not connected to an input

    var newParentId   (default,null): Null<String>;  // if is connected to an input
    var newInputName  (default,null): Null<String>;  // if is connected to an input
    var newCoordinate (default,null): Null<{x:Int, y: Int}>;  // if is not connected to an input
}

/** UI event */
@:native("Blockly.Events.UI")
extern class UI extends Abstract {
    var element  (default,null): String; // name of element that changed: 'selected', 'comment', 'mutatorOpen', etc.
    var oldValue (default,null): String; // previous value of element
    var newValue (default,null): String; // new value of element
}

/** Some possible UI event element types */
class UIElement {
    public static var Selected (default,null) = "selected";
    public static var Comment (default,null) = "comment";
    public static var MutatorOpen (default,null) = "mutatorOpen";

    // TODO: others exist but are not documented
}
