package blockly.event;

import blockly.event.BlockBase.BlockBaseJson;
import blockly.Block.State;

/**
 * Notifies listeners when a block (or connected stack of blocks) is
 * created.
 */
extern class BlockCreate extends BlockBase {

    /** The JSON respresentation of the created block(s). */
    var json: Null<State>;
    
    /** All of the IDs of created blocks. */
    var ids: Null<Array<String>>;

    /** @param opt_block The created block.  Undefined for a blank event. */
    function new(?opt_block: Block);

    /**
     * Encode the event as JSON.
     *
     * @returns JSON representation.
     */
    function toJson(): BlockCreateJson;

    /**
     * Deserializes the JSON event.
     *
     * @param event The event to append new properties to. Should be a subclass
     *     of BlockCreate, but we can't specify that due to the fact that
     *     parameters to static methods in subclasses must be supertypes of
     *     parameters to static methods in superclasses.
     * @internal
     */
    static function fromJson(json: BlockCreateJson, workspace: Workspace, ?event: Any): BlockCreate;

    /**
     * Run a creation event.
     *
     * @param forward True if run forward, false if run backward (undo).
     */
    function run(forward: Bool): Void;
}

typedef BlockCreateJson = BlockBaseJson & {
    var ids: Array<String>;
    var json: Dynamic;
    var ?recordUndo: Bool;
}
