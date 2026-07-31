package blockly.event;

/**
 * Notifies listeners when a block (or connected stack of blocks) is
 * deleted.
 */
extern class BlockDelete extends BlockBase {

    /** The JSON respresentation of the deleted block(s). */
    var oldJson: Null<Block.State>;

    /** All of the IDs of deleted blocks. */
    var ids: Null<Array<String>>;

    /** True if the deleted block was a shadow block, false otherwise. */
    var wasShadow: Null<Bool>;

    /** @param opt_block The deleted block.  Undefined for a blank event. */
    function new(?opt_block: Block);

    /**
     * Encode the event as JSON.
     *
     * @returns JSON representation.
     */
    function toJson(): BlockDeleteJson;

    /**
     * Deserializes the JSON event.
     *
     * @param event The event to append new properties to. Should be a subclass
     *     of BlockDelete, but we can't specify that due to the fact that
     *     parameters to static methods in subclasses must be supertypes of
     *     parameters to static methods in superclasses.
     * @internal
     */
    static function fromJson(json: BlockDeleteJson, workspace: Workspace, ?event: Any): BlockDelete;

    /**
     * Run a deletion event.
     *
     * @param forward True if run forward, false if run backward (undo).
     */
    function run(forward: Bool): Void;
}

typedef BlockDeleteJson = BlockBase.BlockBaseJson & {
    var ids: Array<String>;
    var wasShadow: Bool;
    var oldJson: Block.State;
    var ?recordUndo: Bool;
}
