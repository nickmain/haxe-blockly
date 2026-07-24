package blockly.input;

import blockly.Connection.ConnectionType;
import blockly.field.Field;
import js.html.Element;
import haxe.extern.EitherType;

/**
 * Represents a String or a function that returns a String which can be used as a
 * custom ARIA String to represent an Input, or null if the default fallback should
 * be used. See setAriaLabelProvider for more context.
 */
typedef AriaLabelProvider = EitherType<((input: Input) -> Null<String>), String>;

enum abstract Align(Int) {
    var LEFT = -1;
    var CENTRE = 0;
    var RIGHT = 1;
}

/** Class for an input with optional fields. */
extern class Input {
    var name: String;
    var fieldRow: Array<Field<Any>>;
    var align: Align;
    final type: InputTypes;
    var connection: Null<Connection>;

    /**
     * @param name Language-neutral identifier which may used to find this input
     *     again.
     * @param sourceBlock The block containing this input.
     */
    function new(name: String, sourceBlock: Block);

    /**
     * Get the source block for this input.
     *
     * @returns The block this input is part of.
     */
    function getSourceBlock(): Block;

    /**
     * Add a field (or label from String), and all prefix and suffix fields, to
     * the end of the input's field row.
     *
     * @param field Something to add as a field.
     * @param opt_name Language-neutral identifier which may used to find this
     *     field again.  Should be unique to the host block.
     * @returns The input being append to (to allow chaining).
     */
    function appendField<T>(field: EitherType<String, Field<T>>, ?opt_name: String): Input;

    /**
     * Inserts a field (or label from String), and all prefix and suffix fields,
     * at the location of the input's field row.
     *
     * @param index The index at which to insert field.
     * @param field Something to add as a field.
     * @param opt_name Language-neutral identifier which may used to find this
     *     field again.  Should be unique to the host block.
     * @returns The index following the last inserted field.
     */
    function insertFieldAt<T>(index: Int, field: EitherType<String, Field<T>>, ?opt_name: String): Int;

    /**
     * Remove a field from this input.
     *
     * @param name The name of the field.
     * @param opt_quiet True to prevent an error if field is not present.
     * @returns True if operation succeeds, false if field is not present and
     *     opt_quiet is true.
     * @throws {Error} if the field is not present and opt_quiet is false.
     */
    function removeField(name: String, ?opt_quiet: Bool): Bool;

    /**
     * Gets whether this input is visible or not.
     *
     * @returns True if visible.
     */
    function isVisible(): Bool;

    /**
     * Sets whether this input is visible or not.
     * Should only be used to collapse/uncollapse a block.
     *
     * @param visible True if visible.
     * @returns List of blocks to render.
     * @internal
     */
    function setVisible(visible: Bool): Array<BlockSvg>;

    /**
     * Mark all fields on this input as dirty.
     *
     * @internal
     */
    function markDirty(): Void;

    /**
     * Change a connection's compatibility.
     *
     * @param check Compatible value type or list of value types.  Null if all
     *     types are compatible.
     * @returns The input being modified (to allow chaining).
     */
    function setCheck(check: EitherType<String, Array<String>>): Input;

    /**
     * Change the alignment of the connection's field(s).
     *
     * @param align One of the values of Align.  In RTL mode directions
     *     are reversed, and Align.RIGHT aligns to the left.
     * @returns The input being modified (to allow chaining).
     */
    function setAlign(align: Align): Input;

    /**
     * Changes the connection's shadow block.
     *
     * @param shadow DOM representation of a block or null.
     * @returns The input being modified (to allow chaining).
     */
    function setShadowDom(shadow: Null<Element>): Input;

    /**
     * Returns the XML representation of the connection's shadow block.
     *
     * @returns Shadow DOM representation of a block or null.
     */
    function getShadowDom(): Null<Element>;

    /** Initialize the fields on this input. */
    function init(): Void;

    /**
     * Sets a custom ARIA label provider for this input, or null if it should be reset
     * to use the default method.
     *
     * Inputs do not compute ARIA contexts directly, so the set provider will be used
     * in select cases when the Input needs to be represented (such as for parts of a
     * block label or for connections). Note that overriding this provider will not
     * recompute any already constructed ARIA labels, and it cannot be assumed that the
     * provider will be called any particular number of times during label
     * recomputation. As such, implementations should make sure to provide a
     * deterministic and idempotent ARIA representation each time the provider is
     * called for a given input. It's also fine to reuse providers across multiple
     * Input implementations.
     *
     * @param provider The String or function to use to set the ARIA label for the input
     * @returns The input being modified (to allow chaining).
     */
    function setAriaLabelProvider(provider: Null<AriaLabelProvider>): Input;

    /**
     * Returns the String from the custom ARIA label provider set, or null if the default label (from the field row) should
     * be used. See setAriaLabelProvider for more context.
     */
    function getAriaLabelText(): Null<String>;

    /**
     * Initializes the fields on this input for a headless block.
     *
     * @internal
     */
    function initModel(): Void;

    /**
     * Sever all links to this input.
     */
    function dispose(): Void;

    /**
     * Constructs a connection based on the type of this input's source block.
     * Properly handles constructing headless connections for headless blocks
     * and rendered connections for rendered blocks.
     *
     * @returns a connection of the given type, which is either a headless
     *     or rendered connection, based on the type of this input's source block.
     */
    function makeConnection(type: ConnectionType): Connection;
}
