package blockly;

import blockly.Connection.ConnectionType;
import blockly.input.Input;
import js.html.svg.SVGElement;
import haxe.extern.EitherType;

/**
 * Class for a block's SVG representation.
 * Not normally called directly, workspace.newBlock() is preferred.
 */
extern class BlockSvg extends Block{
    /**
     * Constant for identifying rows that are to be rendered inline.
     * Don't collide with Blockly.inputTypes.
     */
    static final INLINE: Int;
    /**
     * ID to give the "collapsed warnings" warning. Allows us to remove the
     * "collapsed warnings" warning without removing any warnings that belong to
     * the block.
     */
    static final COLLAPSED_WARNING_ID: String;

    /**
     * An optional method which saves a record of blocks connected to
     * this block so they can be later restored after this block is
     * recoomposed (reconfigured).  Typically records the connected
     * blocks on properties on blocks in the mutator flyout, so that
     * rearranging those component blocks will automatically rearrange
     * the corresponding connected blocks on this block after this block
     * is recomposed.
     *
     * To keep the saved connection information up-to-date, MutatorIcon
     * arranges for an event listener to call this method any time the
     * mutator flyout is open and a change occurs on this block's
     * workspace.
     *
     * @param rootBlock The root block in the mutator flyout.
     */
    var saveConnections: Null<(rootBlock: BlockSvg) -> Void>;

    // var customContextMenu: Null<(p1: Array<EitherType<ContextMenuOption, LegacyContextMenuOption>>) -> Void>;

    /**
     * Height of this block, not including any statement blocks above or below.
     * Height is in workspace units.
     */
    var height: Float;

    /**
     * Width of this block, including any connected value blocks.
     * Width is in workspace units.
     */
    var width: Float;
 
    /** Block's mutator icon (if any). */
    // mutator: MutatorIcon | null;
 
    var style: Theme.BlockStyle;
 
    @:native("outputConnection")
    var outputRenderedConnection: Null<RenderedConnection>;
    @:native("nextConnection")
    var nextRenderedConnection: Null<RenderedConnection>;
    @:native("previousConnection")
    var previousRenderedConnection: Null<RenderedConnection>;

    /**
     * @param workspace The block's workspace.
     * @param prototypeName Name of the language object containing type-specific
     *     functions for this block.
     * @param opt_id Optional ID.  Use this ID if provided, otherwise create a new
     *     ID.
     */
    function new(workspace: WorkspaceSvg, prototypeName: String, ?opt_id: String);

    /**
     * Create and initialize the SVG representation of the block.
     * May be called more than once.
     */
    function initSvg(): Void;

    /**
     * Get the secondary colour of a block.
     *
     * @returns #RRGGBB String.
     */
    function getColourSecondary(): String;

    /**
     * Get the tertiary colour of a block.
     *
     * @returns #RRGGBB String.
     */
    function getColourTertiary(): String;

    /** Selects this block. Highlights the block visually. */
    function select(): Void;

    /** Unselects this block. Unhighlights the block visually. */
    function unselect(): Void;

    /**
     * Return the coordinates of the top-left corner of this block relative to the
     * drawing surface's origin (0,0), in workspace units.
     * If the block is on the workspace, (0, 0) is the origin of the workspace
     * coordinate system.
     * This does not change with workspace scale.
     *
     * @returns Object with .x and .y properties in workspace coordinates.
     */
    function getRelativeToSurfaceXY(): Coordinate;

    /**
     * Move a block by a relative offset.
     *
     * @param dx Horizontal offset in workspace units.
     * @param dy Vertical offset in workspace units.
     * @param reason Why is this move happening?  'drag', 'bump', 'snap', ...
     */
    function moveBy(dx: Float, dy: Float, ?reason: Array<String>): Void;

    /**
     * Transforms a block by setting the translation on the transform attribute
     * of the block's SVG.
     *
     * @param x The x coordinate of the translation in workspace units.
     * @param y The y coordinate of the translation in workspace units.
     */
    function translate(x: Float, y: Float): Void;

    /**
     * Move a block to a position.
     *
     * @param xy The position to move to in workspace units.
     * @param reason Why is this move happening?  'drag', 'bump', 'snap', ...
     */
    function moveTo(xy: Coordinate, ?reason: Array<String>): Void;

    /** Snap this block to the nearest grid point. */
    function snapToGrid(): Void;

    /**
     * Returns the coordinates of a bounding box describing the dimensions of this
     * block and any blocks stacked below it.
     * Coordinate system: workspace coordinates.
     *
     * @returns Object with coordinates of the bounding box.
     */
    function getBoundingRectangle(): Rect;
 
    /**
     * Returns the coordinates of a bounding box describing the dimensions of this
     * block alone.
     * Coordinate system: workspace coordinates.
     *
     * @returns Object with coordinates of the bounding box.
     */
    function getBoundingRectangleWithoutChildren(): Rect;

    /**
     * Notify every input on this block to mark its fields as dirty.
     * A dirty field is a field that needs to be re-rendered.
     */
    function markDirty(): Void;

    /**
     * Set whether the block is collapsed or not.
     *
     * @param collapsed True if collapsed.
     */
    function setCollapsed(collapsed: Bool): Void;

    /**
     * Add a CSS class to the SVG group of this block.
     *
     * @param className
     */
    function addClass(className: String): Void;

    /**
     * Remove a CSS class from the SVG group of this block.
     *
     * @param className
     */
    function removeClass(className: String): Void;

    function setDragging(adding: Bool): Void;

    /**
     * Returns whether or not this block is currently being dragged.
     */
    function isDragging(): Bool;

    /**
     * Set whether this block is movable or not.
     *
     * @param movable True if movable.
     */
    function setMovable(movable: Bool): Void;

    /**
     * Set whether this block is editable or not.
     *
     * @param editable True if editable.
     */
    function setEditable(editable: Bool): Void;

    /**
     * Return the root node of the SVG or null if none exists.
     *
     * @returns The root SVG node (probably a group).
     */
    function getSvgRoot(): SVGElement;

    /**
     * Dispose of this block.
     *
     * @param healStack If true, then try to heal any gap by connecting the next
     *     statement with the previous statement.  Otherwise, dispose of all
     *     children of this block.
     * @param animate If true, show a disposal animation and sound.
     */
    function dispose(?healStack: Bool, ?animate: Bool): Void;

    /**
     * Disposes of this block without doing things required by the top block.
     * E.g. does trigger UI effects, remove nodes, etc.
     */
    function disposeInternal(): Void;

    /**
     * Delete a block and hide chaff when doing so. The block will not be deleted
     * if it's in a flyout. This is called from the context menu and keyboard
     * shortcuts as the full delete action. If you are disposing of a block from
     * the workspace and don't need to perform flyout checks, handle event
     * grouping, or hide chaff, then use `block.dispose()` directly.
     */
    function checkAndDelete(): Void;

    /**
     * Encode a block for copying.
     *
     * @param addNextBlocks If true, copy subsequent blocks attached to this one
     *     as well.
     *
     * @returns Copy metadata, or null if the block is an insertion marker.
     */
    // function toCopyData(?addNextBlocks: Bool): Null<BlockCopyData>;

    /**
     * Set this block's warning text.
     *
     * @param text The text, or null to delete.
     * @param id An optional ID for the warning text to be able to maintain
     *     multiple warnings.
     */
    function setWarningText(text: Null<String>, ?id: String): Void;

    /**
     * Give this block a mutator dialog.
     *
     * @param mutator A mutator dialog instance or null to remove.
     */
    // setMutator(mutator: MutatorIcon | null): Void;
    // addIcon<T extends IIcon>(icon: T): T;
    // removeIcon(type: IconType<IIcon>): Bool;

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
     * Add blocklyNotDeletable class when block is not deletable
     * Or remove class when block is deletable
     */
    function setDeletable(deletable: Bool): Void;

    /**
     * Set whether the block is highlighted or not.  Block highlighting is
     * often used to visually mark blocks currently being executed.
     *
     * @param highlighted True if highlighted.
     */
    function setHighlighted(highlighted: Bool): Void;

    /**
     * Adds the visual "select" effect to the block, but does not actually select
     * it or fire an event.
     *
     * @see BlockSvg#select
     */
    function addSelect(): Void;

    /**
     * Removes the visual "select" effect from the block, but does not actually
     * unselect it or fire an event.
     *
     * @see BlockSvg#unselect
     */
    function removeSelect(): Void;

    /**
     * Get the colour of a block.
     *
     * @returns #RRGGBB String.
     */
    function getColour(): String;
    /**
     * Change the colour of a block.
     *
     * @param colour HSV hue value, or #RRGGBB String.
     */
    function setColour(colour: EitherType<Float, String>): Void;

    /**
     * Set the style and colour values of a block.
     *
     * @param blockStyleName Name of the block style.
     * @throws {Error} if the block style does not exist.
     */
    function setStyle(blockStyleName: String): Void;
    
    /**
     * Returns the BlockStyle object used to style this block.
     *
     * @returns This block's style object.
     */
    function getStyle(): Theme.BlockStyle;

    /**
     * Move this block to the front of the visible workspace.
     * <g> tags do not respect z-index so SVG renders them in the
     * order that they are in the DOM.  By placing this block first within the
     * block group's <g>, it will render on top of any other blocks.
     * Use sparingly, this method is expensive because it reorders the DOM
     * nodes.
     *
     * @param blockOnly True to only move this block to the front without
     *     adjusting its parents.
     */
    function bringToFront(?blockOnly: Bool): Void;

    /**
     * Set whether this block can chain onto the bottom of another block.
     *
     * @param newBoolean True if there can be a previous statement.
     * @param opt_check Statement type or list of statement types.  Null/undefined
     *     if any type could be connected.
     */
    function setPreviousStatement(newBoolean: Bool, ?opt_check: Null<EitherType<String, Array<String>>>): Void;
    /**
     * Set whether another block can chain onto the bottom of this block.
     *
     * @param newBoolean True if there can be a next statement.
     * @param opt_check Statement type or list of statement types.  Null/undefined
     *     if any type could be connected.
     */
    function setNextStatement(newBoolean: Bool, ?opt_check: Null<EitherType<String, Array<String>>>): Void;

    /**
     * Set whether this block returns a value.
     *
     * @param newBoolean True if there is an output.
     * @param opt_check Returned type or list of returned types.  Null or
     *     undefined if any type could be returned (e.g. variable get).
     */
    function setOutput(newBoolean: Bool, ?opt_check: Null<EitherType<String, Array<String>>>): Void;

    /**
     * Set whether value inputs are arranged horizontally or vertically.
     *
     * @param newBoolean True if inputs are horizontal.
     */
    function setInputsInline(newBoolean: Bool): Void;

    /**
     * Remove an input from this block.
     *
     * @param name The name of the input.
     * @param opt_quiet True to prevent error if input is not present.
     * @returns True if operation succeeds, false if input is not present and
     *     opt_quiet is true
     * @throws {Error} if the input is not present and opt_quiet is not true.
     */
    function removeInput(name: String, ?opt_quiet: Bool): Bool;

    /**
     * Move a numbered input to a different location on this block.
     *
     * @param inputIndex Index of the input to move.
     * @param refIndex Index of input that should be after the moved input.
     */
    function moveNumberedInputBefore(inputIndex: Int, refIndex: Int): Void;

    /** @override */
    function appendInput(input: Input): Input;

    /**
     * Create a connection of the specified type.
     *
     * @param type The type of the connection to create.
     * @returns A new connection of the specified type.
     * @internal
     */
    function makeConnection_(type: ConnectionType): RenderedConnection;

    /**
     * Return the next statement block directly connected to this block.
     *
     * @returns The next statement block or null.
     */
    function getNextBlock(): Null<BlockSvg>;

    /**
     * Returns the block connected to the previous connection.
     *
     * @returns The previous statement block or null.
     */
    function getPreviousBlock(): Null<BlockSvg>;

    /**
     * Bumps unconnected blocks out of alignment.
     *
     * Two blocks which aren't actually connected should not coincidentally line
     * up on screen, because that creates confusion for end-users.
     */
    function bumpNeighbours(): Void;

    /**
     * Snap to grid, and then bump neighbouring blocks away at the end of the next
     * render.
     */
    function scheduleSnapAndBump(): Void;

    /**
     * Find all the blocks that are directly nested inside this one.
     * Includes value and statement inputs, as well as any following statement.
     * Excludes any connection on an output tab or any preceding statement.
     * Blocks are optionally sorted by position; top to bottom.
     *
     * @param ordered Sort the list if true.
     * @returns Array of blocks.
     */
    function getChildren(ordered: Bool): Array<BlockSvg>;
 
    /**
     * Immediately lays out and reflows a block based on its contents and
     * settings.
     */
    function render(): Void;

    /** Sets the drag strategy for this block. */
    // setDragStrategy(dragStrategy: IDragStrategy): Void;

    /** Returns whether this block is copyable or not. */
    function isCopyable(): Bool;

    /** Returns whether this block is movable or not. */
    function isMovable(): Bool;

    // /** Starts a drag on the block. */
    // startDrag(e?: PointerEvent | KeyboardEvent): IDraggable;
    // /** Drags the block to the given location. */
    // drag(newLoc: Coordinate, e?: PointerEvent | KeyboardEvent): Void;
    // /** Ends the drag on the block. */
    // endDrag(e: PointerEvent | KeyboardEvent | undefined, disposition: DragDisposition): Void;
    // /** Moves the block back to where it was at the start of a drag. */
    // revertDrag(): Void;

    /**
     * Returns a representation of this block that can be displayed in a flyout.
     */
    // toFlyoutInfo(): FlyoutItemInfo[];

    function jsonInit(json: Any): Void;

    /**
     * Returns the number of blocks that this block is nested inside of.
     *
     * @internal
     */
    function getNestingLevel(): Int;

    /**
     * Handles the user acting on this block via keyboard navigation.
     * If this block is in the flyout, a new copy is spawned in move mode on the
     * main workspace. If this block has a single full-block field, that field
     * will be focused. Otherwise, this is a no-op.
     */
    // function performAction(?e: KeyboardEvent): Void;

    /**
     * Returns a description of this block suitable for screenreaders or use in
     * ARIA attributes.
     *
     * @param verbosity How much detail to include in the description.
     * @returns An accessibility description of this block.
     */
    // function getAriaLabel(verbosity: aria.Verbosity): String;
    
    /**
     * Count the number of blocks in this stack (connected by next connections)
     * and return a label to describe it. Uses the standard label if there is only one block.
     *
     * @internal
     */
    function getStackBlocksCountLabel(): String;
}
