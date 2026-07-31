package blockly.event;

enum abstract BlockChangeElement(String) from String to String {
    var Field = "field";
    var Comment = "comment";
    var Collapsed = "collapsed";
    var Disabled = "disabled";
    var Inline = "inline";
    var Mutation = "mutation";
}

/**
 * Notifies listeners when some element of a block has changed (e.g.
 * field values, comments, etc).
 */
extern class BlockChange extends BlockBase {

    /**
     * The element that changed; one of 'field', 'comment', 'collapsed',
     * 'disabled', 'inline', or 'mutation'
     */
    var element: Null<BlockChangeElement>;

    /** The name of the field that changed, if this is a change to a field. */
    var name: Null<String>;

    /** The original value of the element. */
    var oldValue: Null<Any>;

    /** The new value of the element. */
    var newValue: Null<Any>;

    /**
     * @param opt_block The changed block.  Undefined for a blank event.
     * @param opt_element One of 'field', 'comment', 'disabled', etc.
     * @param opt_name Name of input or field affected, or null.
     * @param opt_oldValue Previous value of element.
     * @param opt_newValue New value of element.
     */
    function new(?opt_block: Block, ?opt_element: String, ?opt_name: Null<String>, ?opt_oldValue: Null<Any>, ?opt_newValue: Null<Any>);

    /**
     * Encode the event as JSON.
     *
     * @returns JSON representation.
     */
    function toJson(): BlockChangeJson;

    /**
     * Deserializes the JSON event.
     *
     * @param event The event to append new properties to. Should be a subclass
     *     of BlockChange, but we can't specify that due to the fact that
     *     parameters to static methods in subclasses must be supertypes of
     *     parameters to static methods in superclasses.
     * @internal
     */
    static function fromJson(json: BlockChangeJson, workspace: Workspace, ?event: Any): BlockChange;

    /**
     * Set the language-neutral identifier for the reason why the block was or was
     * not disabled. This is only valid for events where element is 'disabled'.
     * Defaults to 'MANUALLY_DISABLED'.
     *
     * @param disabledReason The identifier of the reason why the block was or was
     *     not disabled.
     */
    function setDisabledReason(disabledReason: String): Void;

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

    /**
     * Returns the extra state of the given block (either as XML or a JSO,
     * depending on the block's definition).
     *
     * @param block The block to get the extra state of.
     * @returns A Stringified version of the extra state of the given block.
     * @internal
     */
    static function getExtraBlockState_(block: BlockSvg): String;
}

typedef BlockChangeJson = BlockBase.BlockBaseJson & {
    var element: String;
    var ?name: String;
    var newValue: Null<Any>;
    var oldValue: Null<Any>;
    var ?disabledReason: String;
}
