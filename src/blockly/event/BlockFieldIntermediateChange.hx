package blockly.event;

/**
 * Notifies listeners when the value of a block's field has changed but the
 * change is not yet complete, and is expected to be followed by a block change
 * event.
 */
extern class BlockFieldIntermediateChange extends BlockBase {

    /** The name of the field that changed. */
    var name: Null<String>;

    /** The original value of the element. */
    var oldValue: Null<Any>;

    /** The new value of the element. */
    var newValue: Null<Any>;

    /**
     * @param opt_block The changed block. Undefined for a blank event.
     * @param opt_name Name of the field affected.
     * @param opt_oldValue Previous value of element.
     * @param opt_newValue New value of element.
     */
    function new(?opt_block: Block, ?opt_name: String, ?opt_oldValue: Any, ?opt_newValue: Any);

    /**
     * Encode the event as JSON.
     *
     * @returns JSON representation.
     */
    function toJson(): BlockFieldIntermediateChangeJson;

    /**
     * Deserializes the JSON event.
     *
     * @param event The event to append new properties to. Should be a subclass
     *     of BlockFieldIntermediateChange, but we can't specify that due to the
     *     fact that parameters to static methods in subclasses must be supertypes
     *     of parameters to static methods in superclasses.
     * @internal
     */
    static function fromJson(json: BlockFieldIntermediateChangeJson, workspace: Workspace, ?event: Any): BlockFieldIntermediateChange;

    /**
     * Does this event record any change of state?
     *
     * @returns False if something changed.
     */
    function isNull(): Bool;

    /**
     * Run a change event.
     *
     * @param forward True if run forward, false if run backward (undo).
     */
    function run(forward: Bool): Void;
}

typedef BlockFieldIntermediateChangeJson = BlockBase.BlockBaseJson & {
    var name: String;
    var newValue: Null<Any>;
    var oldValue: Null<Any>;
}
