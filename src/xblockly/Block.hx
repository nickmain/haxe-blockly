package blockly;

import haxe.extern.EitherType;

@:native("Blockly.Block")
extern class Block {

    /**
     * Find the block with the specified ID.
     */
    public static function getById(id: String): Null<Block>;

    /**
     * The associated Haxe CustomBlock, if any
     */
    public var haxeBlock: Null<CustomBlock>;

    /**
     * Arbitrary data that is round-tripped in serialization
     */
    public var data: String;

    /**
     * The block id
     */
    public var id: String;

    /**
     * The connection object for the output
     */
    public var outputConnection: Null<Connection>;

    /**
     * The connection object for the "next" output
     */
    public var nextConnection: Null<Connection>;

    /**
     * The connection object for the "previous" input
     */
    public var previousConnection: Null<Connection>;

    /**
     * The Inputs of the block
     */
    public var inputList(default,null): Array<Input>;

    /**
     * The workspace the block belongs to
     */
    public var workspace: Workspace;

    /** Whether this block is in a flyout */
    public var isInFlyout (default,null): Bool;

    /** Whether this block is in a mutator */
    public var isInMutator (default,null): Bool;

    /** Whether to show a context menu */
    public var contextMenu: Bool;

    /** Settable callback for customizing the context menu */
    public var customContextMenu: Array<ContextMenuOption> -> Void;

    /**
     * Set the block colour as "#rrggbb" string or 0-360 hue
     */
    public function setColour(rgb: EitherType<Int, String>): Void;

    /**
     * Get the block colour as "#rrggbb"
     */
    public function getColour(): String;

    /**
     * Show the previous-statement socket
     */
    @:overload(function(show: Bool, type: String = null): Void {})
    public function setPreviousStatement(show: Bool, types: Array<String> = null): Void;

    /**
     * Show the next-statement plug
     */
    @:overload(function(show: Bool, type: String = null): Void {})
    public function setNextStatement(show: Bool, types: Array<String> = null): Void;

    /**
     * Show the output plug
     */
    @:overload(function(show: Bool, type: String = null): Void {})
    public function setOutput(show: Bool, types: Array<String> = null): Void;

    /**
     * Set the tool-tip as string or a string-function
     */
    @:overload(function(tip: String): Void {})
    @:overload(function(thunk: Void->String): Void {})
    public function setTooltip(tip: String): Void;

    /**
     * Append a dummy input row to the block
     */
    public function appendDummyInput(name: String = null): Input;

    /**
     * Append a value input to the block
     */
    public function appendValueInput(name: String): Input;

    /**
     * Append a statement input to the block
     */
    public function appendStatementInput(name: String): Input;

    /**
     * Remove an input from this block.
     * @param {boolean=} opt_quiet True to prevent error if input is not present.
     */
    public function removeInput(name: String, opt_quiet: Bool = false): Void;

    public function select(): Void;
    public function unselect(): Void;

    /**
     * Unplug this block from its superior block.  If this block is a statement,
     * optionally reconnect the block underneath with the block on top.
     * @param {boolean} healStack Disconnect child statement and reconnect stack.
     * @param {boolean} bump Move the unplugged block sideways a short distance.
     */
    public function unplug(healStack: Bool, bump: Bool): Void;

    /**
     * Return the parent block or null if this block is at the top level.
     */
    public function getParent(): Null<Block>;

    /**
     * Return the parent block that surrounds the current block, or null if this
     * block has no surrounding block.  A parent block might just be the previous
     * statement, whereas the surrounding block is an if statement, while loop, etc.
     */
    public function getSurroundParent(): Null<Block>;

    /**
     * Return the next statement block directly connected to this block or null
     */
    public function getNextBlock(): Null<Block>;

    /**
     * Return the top-most block in this block's tree.
     * This will return itself if this block is at the top level.
     */
    public function getRootBlock(): Block;

    /**
     * Find all the blocks that are directly nested inside this one.
     * Includes value and block inputs, as well as any following statement.
     * Excludes any connection on an output tab or any preceding statement.
     */
    public function getChildren(): Array<Block>;

    /**
     * Set parent of this block to be a BlocklyApp block or null.
     */
    public function setParent(newParent: Block): Void;

    /**
     * Find all the blocks that are directly or indirectly nested inside this one.
     * Includes this block in the list.
     * Includes value and block inputs, as well as any following statements.
     * Excludes any connection on an output tab or any preceding statements.
     */
    public function getDescendants(): Array<Block>;

    /**
     * Get whether this block is deletable or not.
     */
    public function isDeletable(): Bool;

    /**
     * Set whether this block is deletable or not.
     */
    public function setDeletable(deletable: Bool): Void;

    /**
     * Get whether this block is movable or not.
     */
    public function isMovable(): Bool;

    /**
     * Set whether this block is movable or not.
     */
    public function setMovable(movable: Bool): Void;

    /**
     * Get whether this block is a shadow block or not.
     */
    public function isShadow(): Bool;

    /**
     * Set whether this block is a shadow block or not.
     */
    public function setShadow(shadow: Bool): Void;

    /**
     * Get whether this block is editable or not.
     */
    public function isEditable(): Bool;

    /**
     * Set whether this block is editable or not.
     */
    public function setEditable(editable: Bool): Void;

    /**
     * Set the URL of this block's help page. Null for no help.
     */
    public function setHelpUrl(url: String): Void;

    /**
     * Returns the named field from a block.
     */
    public function getField(name: String): Null<Field>;

    /**
     * Returns the language-neutral value from the field of a block.
     */
    public function getFieldValue(name: String): Null<String>;

    /**
     * Change the field value for a block (e.g. 'CHOOSE' or 'REMOVE').
     */
    public function setFieldValue(newValue: String, fieldName: String): Void;

    /**
     * Set whether value inputs are arranged horizontally or vertically.
     */
    public function setInputsInline(isInline: Null<Bool>): Void;

    /**
     * Get whether value inputs are arranged horizontally or vertically.
     */
    public function getInputsInline(): Null<Bool>;

    /**
     * Set whether the block is disabled or not.
     */
    public function setDisabled(disabled: Bool): Void;

    /**
     * Whether the block is disabled or not. (Read only)
     */
    public var disabled: Bool;

    /**
     * Get whether the block is disabled or not due to parents.
     * The block's own disabled property is not considered.
     */
    public function getInheritedDisabled(): Bool;

    /**
     * Set whether the block is collapsed or not.
     */
    public function setCollapsed(collapsed: Bool): Void;

    /**
     * Get whether the block is collapsed or not.
     */
    public function isCollapsed(): Bool;

    /**
     * Initialize this block using a cross-platform, internationalization-friendly
     * JSON description.
     */
    public function jsonInit(json: String): Void;

    /**
     * Move a named input to a different location on this block.
     * @param {string} name The name of the input to move.
     * @param {?string} refName Name of input that should be after the moved input,
     *   or null to be the input at the end.
     */
    public function moveInputBefore(name: String, refName: String = null): Void;

    /**
     * Move a numbered input to a different location on this block.
     * @param {number} inputIndex Index of the input to move.
     * @param {number} refIndex Index of input that should be after the moved input.
     */
    public function moveNumberedInputBefore(inputIndex: Int, refIndex: Int): Void;

    /**
     * Fetches the named input object.
     */
    public function getInput(name: String): Null<Input>;

    /**
     * Fetches the block attached to the named input.
     */
    public function getInputTargetBlock(name: String): Null<Block>;

    /**
     * Returns the comment on this block (or '' if none).
     */
    public function getCommentText(): String;

    /**
     * Set this block's comment text.
     * @param {?string} text The text, or null to delete.
     */
    public function setCommentText(text: String): Void;

    /**
     * The comment icon
     */
    public var comment: Null<Comment>;

    /**
     * Set this block's warning text.
     * @param {?string} text The text, or null to delete.
     */
    public function setWarningText(text: String): Void;

    /**
     * The warning icon
     */
    public var warning: Null<Warning>;

    /**
     * Give this block a mutator dialog.
     * @param mutator A mutator dialog instance or null to remove.
     */
    public function setMutator(mutator: Mutator): Void;

    /**
     * Create and initialize the SVG representation of the block.
     * May be called more than once.
     */
    public function initSvg(): Void;

    /**
     * Render the block.
     * Lays out and reflows a block based on its contents and settings.
     * @param {boolean=} opt_bubble If false, just render this block.
     *   If true, also render block's parent, grandparent, etc.
     */
    public function render(opt_bubble: Bool): Void;

}
