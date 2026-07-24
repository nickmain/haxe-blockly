package blockly;

import blockly.field.Field;
import blockly.input.Input;
import blockly.event.AbstractEvent;
import haxe.extern.EitherType;

/**
 * Represents the state of a connection.
 */
typedef ConnectionState = {
    var ?shadow: State;
    var ?block: State;
}

/**
 * Represents the state of a given block.
 */
typedef State = {
    var type: String;
    var ?id: String;
    var ?x: Float;
    var ?y: Float;
    var ?collapsed: Bool;
    var ?deletable: Bool;
    var ?movable: Bool;
    var ?editable: Bool;
    var ?enabled: Bool;
    var ?disabledReasons: Array<String>;
    @:native("inline") var ?_inline: Bool;
    var ?data: String;
    var ?extraState: Any;
    var ?icons: Map<String, Any>;
    var ?fields: Map<String, Any>;
    var ?inputs: Map<String, ConnectionState>;
    var ?next: ConnectionState;
}

typedef CommentModel = {
    var text: Null<String>;
    var pinned: Bool;
    var size: Size;
}

/**
 * Class for one block.
 * Not normally called directly, workspace.newBlock() is preferred.
 */
extern class Block {
    /**
     * An optional callback method to use whenever the block's parent workspace
     * changes. This is usually only called from the constructor, the block type
     * initializer function, or an extension initializer function.
     */
    var onchange: Null<((p1: AbstractEvent) -> Void)>;

    /** The language-neutral ID given to the collapsed input. */
    static final COLLAPSED_INPUT_NAME: String;
    
    /** The language-neutral ID given to the collapsed field. */
    static final COLLAPSED_FIELD_NAME: String;

    /**
     * Optional text data that round-trips between blocks and XML.
     * Has no effect. May be used by 3rd parties for meta information.
     */
    var data: Null<String>;
    
    /** An optional method called during initialization. */
    var init: Null<() -> Void>;

    /** An optional method called during disposal. */
    var destroy: Null<() -> Void>;

    /**
     * An optional serialization method for defining how to serialize the
     * block's extra state (eg mutation state) to something JSON compatible.
     * This must be coupled with defining `loadExtraState`.
     *
     * @param doFullSerialization Whether or not to serialize the full state of
     *     the extra state (rather than possibly saving a reference to some
     *     state). This is used during copy-paste. See the
     *     {@link https://developers.devsite.google.com/blockly/guides/create-custom-blocks/extensions#full_serialization_and_backing_data | block serialization docs}
     *     for more information.
     */
    var saveExtraState: Null<(?doFullSerialization: Bool) -> Any>;

    /**
     * An optional serialization method for defining how to deserialize the
     * block's extra state (eg mutation state) from something JSON compatible.
     * This must be coupled with defining `saveExtraState`.
     */
    var loadExtraState: Null<(p1: Any) -> Void>;

    /**
     * An optional property for suppressing adding STATEMENT_PREFIX and
     * STATEMENT_SUFFIX to generated code.
     */
    var suppressPrefixSuffix: Null<Bool>;

    /**
     * An optional method for declaring developer variables, to be used
     * by generators.  Developer variables are never shown to the user,
     * but are declared as global variables in the generated code.
     *
     * @returns a list of developer variable names.
     */
    var getDeveloperVariables: Null<() -> Array<String>>;

    /**
     * An optional method that reconfigures the block based on the
     * contents of the mutator dialog.
     *
     * @param rootBlock The root block in the mutator flyout.
     */
    var compose: Null<(rootBlock: Block) -> Void>;

    /**
     * An optional function that populates the mutator flyout with
     * blocks representing this block's configuration.
     *
     * @param workspace The mutator flyout's workspace.
     * @returns The root block created in the flyout's workspace.
     */
    var decompose: Null<(workspace: Workspace) -> Block>;

    var id: String;
    var outputConnection: Null<Connection>;
    var nextConnection: Null<Connection>;
    var previousConnection: Null<Connection>;
    var inputList: Array<Input>;
    var inputsInline: Bool;
    // icons: IIcon[];
    var tooltip: Tooltip.TipInfo;
    var contextMenu: Bool;

    var isInFlyout: Bool;
    var isInMutator: Bool;
    var RTL: Bool;

    /** Name of the type of hat. */
    var hat: Null<String>;

    /** Is this block a BlockSVG? */
    final rendered: Bool;

    /**
     * String for block help, or function that returns a URL. Null for no help.
     */
    var helpUrl: Null<EitherType<String, (() -> String)>>;

    var type: String;
    var inputsInlineDefault: Bool;
    var workspace: Workspace;

    /**
     * @param workspace The block's workspace.
     * @param prototypeName Name of the language object containing type-specific
     *     functions for this block.
     * @param opt_id Optional ID.  Use this ID if provided, otherwise create a new
     *     ID.
     * @throws When the prototypeName is not valid or not allowed.
     */
    function new(workspace: Workspace, prototypeName: String, ?opt_id: String);

    /**
     * Dispose of this block.
     *
     * @param healStack If true, then try to heal any gap by connecting the next
     *     statement with the previous statement.  Otherwise, dispose of all
     *     children of this block.
     */
    function dispose(?healStack: Bool): Void;

    /**
     * Returns true if the block is either in the process of being disposed, or
     * is disposed.
     *
     * @internal
     */
    function isDeadOrDying(): Bool;

    /**
     * Call initModel on all fields on the block.
     * May be called more than once.
     * Either initModel or initSvg must be called after creating a block and
     * before the first interaction with it.  Interactions include UI actions
     * (e.g. clicking and dragging) and firing events (e.g. create, delete, and
     * change).
     */
    function initModel(): Void;

    /**
     * Unplug this block from its superior block.  If this block is a statement,
     * optionally reconnect the block underneath with the block on top.
     *
     * @param opt_healStack Disconnect child statement and reconnect stack.
     *     Defaults to false.
     */
    function unplug(?opt_healStack: Bool): Void;

    /**
     * Returns all connections originating from this block.
     *
     * @param _all If true, return all connections even hidden ones.
     * @returns Array of connections.
     * @internal
     */
    function getConnections_(_all: Bool): Array<Connection>;

    /**
     * Walks down a stack of blocks and finds the last next connection on the
     * stack.
     *
     * @param ignoreShadows If true,the last connection on a non-shadow block will
     *     be returned. If false, this will follow shadows to find the last
     *     connection.
     * @returns The last next connection on the stack, or null.
     * @internal
     */
    function lastConnectionInStack(ignoreShadows: Bool): Null<Connection>;

    /**
     * Bump unconnected blocks out of alignment.  Two blocks which aren't actually
     * connected should not coincidentally line up on screen.
     */
    function bumpNeighbours(): Void;

    /**
     * Return the parent block or null if this block is at the top level. The
     * parent block is either the block connected to the previous connection (for
     * a statement block) or the block connected to the output connection (for a
     * value block).
     *
     * @returns The block (if any) that holds the current block.
     */
    function getParent(): Null<Block>;

    /**
     * Return the input that connects to the specified block.
     *
     * @param block A block connected to an input on this block.
     * @returns The input (if any) that connects to the specified block.
     */
    function getInputWithBlock(block: Block): Null<Input>;

    /**
     * Return the parent block that surrounds the current block, or null if this
     * block has no surrounding block.  A parent block might just be the previous
     * statement, whereas the surrounding block is an if statement, while loop,
     * etc.
     *
     * @returns The block (if any) that surrounds the current block.
     */
    function getSurroundParent(): Null<Block>;

    /**
     * Return the next statement block directly connected to this block.
     *
     * @returns The next statement block or null.
     */
    function getNextBlock(): Null<Block>;

    /**
     * Returns the block connected to the previous connection.
     *
     * @returns The previous statement block or null.
     */
    function getPreviousBlock(): Null<Block>;

    /**
     * Return the top-most block in this block's tree.
     * This will return itself if this block is at the top level.
     *
     * @returns The root block.
     */
    function getRootBlock(): Block;

    /**
     * Walk up from the given block up through the stack of blocks to find
     * the top block of the sub stack. If we are nested in a statement input only
     * find the top-most nested block. Do not go all the way to the root block.
     *
     * @returns The top block in a stack.
     * @internal
     */
    function getTopStackBlock(): Block;

    /**
     * Find all the blocks that are directly nested inside this one.
     * Includes value and statement inputs, as well as any following statement.
     * Excludes any connection on an output tab or any preceding statement.
     * Blocks are optionally sorted by position; top to bottom.
     *
     * @param ordered Sort the list if true.
     * @returns Array of blocks.
     */
    function getChildren(ordered: Bool): Array<Block>;

    /**
     * Set parent of this block to be a new block or null.
     *
     * @param newParent New parent block.
     * @internal
     */
    function setParent(newParent: Null<Block>): Void;

    /**
     * Find all the blocks that are directly or indirectly nested inside this one.
     * Includes this block in the list.
     * Includes value and statement inputs, as well as any following statements.
     * Excludes any connection on an output tab or any preceding statements.
     * Blocks are optionally sorted by position; top to bottom.
     *
     * @param ordered Sort the list if true.
     * @returns Flattened array of blocks.
     */
    function getDescendants(ordered: Bool): Array<Block>;

    /**
     * Get whether this block is deletable or not.
     *
     * @returns True if deletable.
     */
    function isDeletable(): Bool;

    /**
     * Return whether this block's own deletable property is true or false.
     *
     * @returns True if the block's deletable property is true, false otherwise.
     */
    function isOwnDeletable(): Bool;

    /**
     * Set whether this block is deletable or not.
     *
     * @param deletable True if deletable.
     */
    function setDeletable(deletable: Bool): Void;

    /**
     * Get whether this block is movable or not.
     *
     * @returns True if movable.
     * @internal
     */
    function isMovable(): Bool;

    /**
     * Return whether this block's own movable property is true or false.
     *
     * @returns True if the block's movable property is true, false otherwise.
     * @internal
     */
    function isOwnMovable(): Bool;

    /**
     * Set whether this block is movable or not.
     *
     * @param movable True if movable.
     */
    function setMovable(movable: Bool): Void;

    /**
     * Get whether is block is duplicatable or not. If duplicating this block and
     * descendants will put this block over the workspace's capacity this block is
     * not duplicatable. If duplicating this block and descendants will put any
     * type over their maxInstances this block is not duplicatable.
     *
     * @returns True if duplicatable.
     */
    function isDuplicatable(): Bool;

    /**
     * Get whether this block is a shadow block or not.
     *
     * @returns True if a shadow.
     */
    function isShadow(): Bool;

    /**
     * Get whether this block is an insertion marker block or not.
     *
     * @returns True if an insertion marker.
     */
    function isInsertionMarker(): Bool;

    /**
     * Set whether this block is an insertion marker block or not.
     * Once set this cannot be unset.
     *
     * @param insertionMarker True if an insertion marker.
     * @internal
     */
    function setInsertionMarker(insertionMarker: Bool): Void;

    /**
     * Get whether this block is editable or not.
     *
     * @returns True if editable.
     * @internal
     */
    function isEditable(): Bool;

    /**
     * Return whether this block's own editable property is true or false.
     *
     * @returns True if the block's editable property is true, false otherwise.
     */
    function isOwnEditable(): Bool;

    /**
     * Set whether this block is editable or not.
     *
     * @param editable True if editable.
     */
    function setEditable(editable: Bool): Void;

    /**
     * Returns if this block has been disposed of / deleted.
     *
     * @returns True if this block has been disposed of / deleted.
     */
    function isDisposed(): Bool;

    /**
     * Determines and returns the full-block field for this block, or null if there isn't one
     * and this block can't be considered a singleton field block.
     *
     * Note that this method is unreliable if a block contains a single field that
     * hasn't been initialized/rendered yet.
     *
     * @returns The full-block field this block contains, or null if it doesn't contain one.
     * @internal
     */
    function getFullBlockField(): Null<Field<Any>>;

    /**
     * A block is a simple reporter if it has an output connection and exactly one field.
     * In some renderers, simple reporters are rendered differently from other blocks.
     * Being a simple reporter block is a prerequisite to the single field rendering itself
     * as a "full-block field", but it is not sufficient, as not all fields or renderers use
     * this special rendering. Use `getFullBlockField` to determine if the block is rendered
     * as a "full-block field block".
     *
     * @returns True if this block is a value block with a single field.
     * @internal
     */
    function isSimpleReporter(): Bool;

    /**
     * Find the connection on this block that corresponds to the given connection
     * on the other block.
     * Used to match connections between a block and its insertion marker.
     *
     * @param otherBlock The other block to match against.
     * @param conn The other connection to match.
     * @returns The matching connection on this block, or null.
     * @internal
     */
    function getMatchingConnection(otherBlock: Block, conn: Connection): Null<Connection>;

    /**
     * Set the URL of this block's help page.
     *
     * @param url URL String for block help, or function that returns a URL.  Null
     *     for no help.
     */
    function setHelpUrl(url: EitherType<String, () -> String>): Void;

    /**
     * Sets the tooltip for this block.
     *
     * @param newTip The text for the tooltip, a function that returns the text
     *     for the tooltip, or a parent object whose tooltip will be used. To not
     *     display a tooltip pass the empty String.
     */
    function setTooltip(newTip: Tooltip.TipInfo): Void;

    /**
     * Returns the tooltip text for this block.
     *
     * @returns The tooltip text for this block.
     */
    function getTooltip(): String;

    /**
     * Get the colour of a block.
     *
     * @returns #RRGGBB String.
     */
    function getColour(): String;

    /**
     * Get the name of the block style.
     *
     * @returns Name of the block style.
     */
    function getStyleName(): String;

    /**
     * Get the HSV hue value of a block.  Null if hue not set.
     *
     * @returns Hue value (0-360).
     */
    function getHue(): Null<Float>;

    /**
     * Change the colour of a block.
     *
     * @param colour HSV hue value (0 to 360), #RRGGBB String, or a message
     *     reference String pointing to one of those two values.
     */
    function setColour(colour: EitherType<Float, String>): Void;

    /**
     * Set the style and colour values of a block.
     *
     * @param blockStyleName Name of the block style.
     */
    function setStyle(blockStyleName: String): Void;

    /**
     * Sets a callback function to use whenever the block's parent workspace
     * changes, replacing any prior onchange handler. This is usually only called
     * from the constructor, the block type initializer function, or an extension
     * initializer function.
     *
     * @param onchangeFn The callback to call when the block's workspace changes.
     * @throws {Error} if onchangeFn is not falsey and not a function.
     */
    function setOnChange(onchangeFn: (p1: AbstractEvent) -> Void): Void;

    /**
     * Returns the named field from a block.
     *
     * @param name The name of the field.
     * @returns Named field, or null if field does not exist.
     */
    function getField(name: String): Null<Field<Any>>;

    /**
     * Returns a generator that provides every field on the block.
     *
     * @returns A generator that can be used to iterate the fields on the block.
     */
    function getFields(): utils.Generator.JSGenerator<Field<Any>>;

    /**
     * Return all variables referenced by this block.
     *
     * @returns List of variable models.
     */
    // function getVarModels(): Array<IVariableModel<IVariableState>>;

    /**
     * Notification that a variable is renaming but keeping the same ID.  If the
     * variable is in use on this block, rerender to show the new name.
     *
     * @param variable The variable being renamed.
     * @internal
     */
    // function updateVarName(variable: IVariableModel<IVariableState>): Void;

    /**
     * Notification that a variable is renaming.
     * If the ID matches one of this block's variables, rename it.
     *
     * @param oldId ID of variable to rename.
     * @param newId ID of new variable.  May be the same as oldId, but with an
     *     updated name.
     */
    // function renameVarById(oldId: String, newId: String): Void;

    /**
     * Returns the language-neutral value of the given field.
     *
     * @param name The name of the field.
     * @returns Value of the field or null if field does not exist.
     */
    function getFieldValue(name: String): Any;

    /**
     * Sets the value of the given field for this block.
     *
     * @param newValue The value to set.
     * @param name The name of the field to set the value of.
     */
    function setFieldValue(newValue: Any, name: String): Void;

    /**
     * Set whether this block can chain onto the bottom of another block.
     *
     * @param newBool True if there can be a previous statement.
     * @param opt_check Statement type or list of statement types.  Null/undefined
     *     if any type could be connected.
     */
    function setPreviousStatement(newBool: Bool, ?opt_check: Null<EitherType<String, Array<String>>>): Void;

    /**
     * Set whether another block can chain onto the bottom of this block.
     *
     * @param newBool True if there can be a next statement.
     * @param opt_check Statement type or list of statement types.  Null/undefined
     *     if any type could be connected.
     */
    function setNextStatement(newBool: Bool, ?opt_check: Null<EitherType<String, Array<String>>>): Void;

    /**
     * Set whether this block returns a value.
     *
     * @param newBool True if there is an output.
     * @param opt_check Returned type or list of returned types.  Null or
     *     undefined if any type could be returned (e.g. variable get).
     */
    function setOutput(newBool: Bool, ?opt_check: Null<EitherType<String, Array<String>>>): Void;

    /**
     * Set whether value inputs are arranged horizontally or vertically.
     *
     * @param newBool True if inputs are horizontal.
     */
    function setInputsInline(newBool: Bool): Void;

    /**
     * Get whether value inputs are arranged horizontally or vertically.
     *
     * @returns True if inputs are horizontal.
     */
    function getInputsInline(): Bool;

    /**
     * Set the block's output shape.
     *
     * @param outputShape Value representing an output shape.
     */
    function setOutputShape(outputShape: Null<Int>): Void;

    /**
     * Get the block's output shape.
     *
     * @returns Value representing output shape if one exists.
     */
    function getOutputShape(): Null<Int>;

    /**
     * Get whether this block is enabled or not. A block is considered enabled
     * if there aren't any reasons why it would be disabled. A block may still
     * be disabled for other reasons even if the user attempts to manually
     * enable it, such as when the block is in an invalid location.
     *
     * @returns True if enabled.
     */
    function isEnabled(): Bool;

    /**
     * Add or remove a reason why the block might be disabled. If a block has
     * any reasons to be disabled, then the block itself will be considered
     * disabled. A block could be disabled for multiple independent reasons
     * simultaneously, such as when the user manually disables it, or the block
     * is invalid.
     *
     * @param disabled If true, then the block should be considered disabled for
     *     at least the provided reason, otherwise the block is no longer disabled
     *     for that reason.
     * @param reason A language-neutral identifier for a reason why the block
     *     could be disabled. Call this method again with the same identifier to
     *     update whether the block is currently disabled for this reason.
     */
    function setDisabledReason(disabled: Bool, reason: String): Void;

    /**
     * Get whether the block is disabled or not due to parents.
     * The block's own disabled property is not considered.
     *
     * @returns True if disabled.
     */
    function getInheritedDisabled(): Bool;

    /**
     * Get whether the block is currently disabled for the provided reason.
     *
     * @param reason A language-neutral identifier for a reason why the block
     *     could be disabled.
     * @returns Whether the block is disabled for the provided reason.
     */
    function hasDisabledReason(reason: String): Bool;

    /**
     * Get a set of reasons why the block is currently disabled, if any. If the
     * block is enabled, this set will be empty.
     *
     * @returns The set of reasons why the block is disabled, if any.
     */
    // function getDisabledReasons(): ReadonlySet<String>;

    /**
     * Get whether the block is collapsed or not.
     *
     * @returns True if collapsed.
     */
    function isCollapsed(): Bool;

    /**
     * Set whether the block is collapsed or not.
     *
     * @param collapsed True if collapsed.
     */
    function setCollapsed(collapsed: Bool): Void;

    /**
     * Set a custom aria role description provider for this block. If not set,
     * uses a default provider based on the block's properties (e.g. whether it has
     * inputs, outputs, etc.).
     *
     * @param description The description or function to provide the description.
     *   If a String, we'll replace message references in the String, e.g.
     *   `%{BKY_CUSTOM_MESSAGE}` will be replaced with the value of
     *   `Blockly.Msg['CUSTOM_MESSAGE']`.}'
     */
    function setAriaRoleDescriptionProvider(description: EitherType<String, (() -> String)>): Void;

    /**
     * @returns The String to use as the role description for this block. If a
     *    custom provider has been set, use that. Otherwise, return a default
     *    description based on the block's properties.
     */
    function getAriaRoleDescription(): String;

    /**
     * Create a human-readable text representation of this block and any children.
     *
     * @param opt_maxLength Truncate the String to this length.
     * @param opt_emptyToken The placeholder String used to denote an empty input.
     *     If not specified, '?' is used.
     * @returns Text of block.
     */
    function toString(?opt_maxLength: Int, ?opt_emptyToken: String): String;

    /**
     * Appends a value input row.
     *
     * @param name Language-neutral identifier which may used to find this input
     *     again.  Should be unique to this block.
     * @returns The input object created.
     */
    function appendValueInput(name: String): Input;

    /**
     * Appends a statement input row.
     *
     * @param name Language-neutral identifier which may used to find this input
     *     again.  Should be unique to this block.
     * @returns The input object created.
     */
    function appendStatementInput(name: String): Input;

    /**
     * Appends a dummy input row.
     *
     * @param name Optional language-neutral identifier which may used to find
     *     this input again.  Should be unique to this block.
     * @returns The input object created.
     */
    function appendDummyInput(?name: String): Input;

    /**
     * Appends an input that ends the row.
     *
     * @param name Optional language-neutral identifier which may used to find
     *     this input again.  Should be unique to this block.
     * @returns The input object created.
     */
    function appendEndRowInput(?name: String): Input;

    /**
     * Appends the given input row.
     *
     * Allows for custom inputs to be appended to the block.
     */
    function appendInput(input: Input): Input;

    /**
     * Initialize this block using a cross-platform, internationalization-friendly
     * JSON description.
     *
     * @param json Structured data describing the block.
     */
    function jsonInit(json: Any): Void;

    /**
     * Add key/values from mixinObj to this block object. By default, this method
     * will check that the keys in mixinObj will not overwrite existing values in
     * the block, including prototype values. This provides some insurance against
     * mixin / extension incompatibilities with future block features. This check
     * can be disabled by passing true as the second argument.
     *
     * @param mixinObj The key/values pairs to add to this block object.
     * @param opt_disableCheck Option flag to disable overwrite checks.
     */
    function mixin(mixinObj: Any, ?opt_disableCheck: Bool): Void;

    /**
     * Move a named input to a different location on this block.
     *
     * @param name The name of the input to move.
     * @param refName Name of input that should be after the moved input, or null
     *     to be the input at the end.
     */
    function moveInputBefore(name: String, refName: Null<String>): Void;

    /**
     * Move a numbered input to a different location on this block.
     *
     * @param inputIndex Index of the input to move.
     * @param refIndex Index of input that should be after the moved input.
     */
    function moveNumberedInputBefore(inputIndex: Int, refIndex: Int): Void;

    /**
     * Remove an input from this block.
     *
     * @param name The name of the input.
     * @param opt_quiet True to prevent an error if input is not present.
     * @returns True if operation succeeds, false if input is not present and
     *     opt_quiet is true.
     * @throws {Error} if the input is not present and opt_quiet is not true.
     */
    function removeInput(name: String, ?opt_quiet: Bool): Bool;

    /**
     * Fetches the named input object.
     *
     * @param name The name of the input.
     * @returns The input object, or null if input does not exist.
     */
    function getInput(name: String): Null<Input>;

    /**
     * Fetches the block attached to the named input.
     *
     * @param name The name of the input.
     * @returns The attached value block, or null if the input is either
     *     disconnected or if the input does not exist.
     */
    function getInputTargetBlock(name: String): Null<Block>;

    /**
     * Returns the comment on this block (or null if there is no comment).
     *
     * @returns Block's comment.
     */
    function getCommentText(): Null<String>;

    /**
     * Set this block's comment text.
     *
     * @param text The text, or null to delete.
     */
    function setCommentText(text: Null<String>): Void;

    /**
     * Set this block's warning text.
     *
     * @param _text The text, or null to delete.
     * @param _opt_id An optional ID for the warning text to be able to maintain
     *     multiple warnings.
     */
    function setWarningText(_text: Null<String>, ?_opt_id: String): Void;

    // /**
    //  * Give this block a mutator dialog.
    //  *
    //  * @param _mutator A mutator dialog instance or null to remove.
    //  */
    // setMutator(_mutator: MutatorIcon): Void;
    // /** Adds the given icon to the block. */
    // addIcon<T extends IIcon>(icon: T): T;
    // /**
    //  * Removes the icon whose getType matches the given type iconType from the
    //  * block.
    //  *
    //  * @param type The type of the icon to remove from the block.
    //  * @returns True if an icon with the given type was found, false otherwise.
    //  */
    // removeIcon(type: IconType<IIcon>): Bool;
    // /**
    //  * @returns True if an icon with the given type exists on the block,
    //  *     false otherwise.
    //  */
    // hasIcon(type: IconType<IIcon>): Bool;

    // /**
    //  * @param type The type of the icon to retrieve. Prefer passing an `IconType`
    //  *     for proper type checking when using typescript.
    //  * @returns The icon with the given type if it exists on the block, undefined
    //  *     otherwise.
    //  */
    // getIcon<T extends IIcon>(type: IconType<T> | String): T | undefined;

    // /** @returns An array of the icons attached to this block. */
    // function getIcons(): Array<IIcon>;

    /**
     * Return the coordinates of the top-left corner of this block relative to the
     * drawing surface's origin (0,0), in workspace units.
     *
     * @returns Object with .x and .y properties.
     */
    function getRelativeToSurfaceXY(): Coordinate;

    /**
     * Move a block by a relative offset.
     *
     * @param dx Horizontal offset, in workspace units.
     * @param dy Vertical offset, in workspace units.
     * @param reason Why is this move happening?  'drag', 'bump', 'snap', ...
     */
    function moveBy(dx: Float, dy: Float, ?reason: Array<String>): Void;

    /**
     * Create a connection of the specified type.
     *
     * @param type The type of the connection to create.
     * @returns A new connection of the specified type.
     * @internal
     */
    function makeConnection_(type: Connection.ConnectionType): Connection;

    /**
     * Recursively checks whether all statement and value inputs are filled with
     * blocks. Also checks all following statement blocks in this stack.
     *
     * @param opt_shadowBlocksAreFilled An optional argument controlling whether
     *     shadow blocks are counted as filled. Defaults to true.
     * @returns True if all inputs are filled, false otherwise.
     */
    function allInputsFilled(?opt_shadowBlocksAreFilled: Bool): Bool;

    /**
     * This method returns a String describing this Block in developer terms (type
     * name and ID; English only).
     *
     * Intended to on be used in console logs and errors. If you need a String
     * that uses the user's native language (including block text, field values,
     * and child blocks), use {@link (Block:class).toString | toString()}.
     *
     * @returns The description.
     */
    function toDevString(): String;
}
