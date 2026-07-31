package blockly.event;

import blockly.event.AbstractEvent.AbstractEventJson;

/**
 * Abstract class for any event related to blocks.
 */
extern class BlockBase extends AbstractEvent {

    /** The ID of the block associated with this event. */
    var blockId: Null<String>;

    /**
     * @param opt_block The block this event corresponds to.
     *     Undefined for a blank event.
     */
    function new(?opt_block: Block);

    /**
     * Encode the event as JSON.
     *
     * @returns JSON representation.
     */
    function toJson(): BlockBaseJson;

    /**
     * Deserializes the JSON event.
     *
     * @param event The event to append new properties to. Should be a subclass
     *     of BlockBase, but we can't specify that due to the fact that parameters
     *     to static methods in subclasses must be supertypes of parameters to
     *     static methods in superclasses.
     * @internal
     */
    static function fromJson(json: BlockBaseJson, workspace: Workspace, ?event: Any): BlockBase;
}

typedef BlockBaseJson = AbstractEventJson & {
    var blockId: String;
}
