package blockly;

import blockly.event.AbstractEvent;

extern class Options {}

/**
 * Class for a workspace.  This is a data structure that contains blocks.
 * There is no UI, and can be created headlessly.
 */
extern class Workspace {
    /**
     * Angle away from the horizontal to sweep for blocks.  Order of execution is
     * generally top to bottom, but a small angle changes the scan to give a bit
     * of a left to right bias (reversed in RTL).  Units are in degrees. See:
     * https://tvtropes.org/pmwiki/pmwiki.php/Main/DiagonalBilling
     */
    static var SCAN_ANGLE: Float;

    var id: String;
    var options: Options;
    var RTL: Bool;
    var horizontalLayout: Bool;
    var toolboxPosition: Toolbox.Position;

    /**
     * Returns `true` if the workspace is visible and `false` if it's headless.
     */
    var rendered: Bool;

    /** Is this workspace the surface for a flyout? */
    var isFlyout: Bool;

    /** Is this workspace the surface for a mutator? */
    var isMutator: Bool;
    
    /**
     * Maximum number of undo events in stack. `0` turns off undo, `Infinity`
     * sets it to unlimited.
     */
    var MAX_UNDO: Float;

    // NOTE: ConnectionDB is not currently implemented in Haxe

    /**
     * Dispose of this workspace.
     * Unlink from all DOM elements to prevent memory leaks.
     */
    function dispose(): Void;

    /**
     * Adds a block to the list of top blocks.
     *
     * @param block Block to add.
     */
    function addTopBlock(block: Block): Void;

    /**
     * Removes a block from the list of top blocks.
     *
     * @param block Block to remove.
     */
    function removeTopBlock(block: Block): Void;

    /**
     * Finds the top-level blocks and returns them.  Blocks are optionally sorted
     * by position; top to bottom (with slight LTR or RTL bias).
     *
     * @param ordered Sort the list if true.
     * @returns The top-level block objects.
     */
    function getTopBlocks(?ordered: Bool): Array<Block>;

    /**
     * Add a block to the list of blocks keyed by type.
     *
     * @param block Block to add.
     */
    function addTypedBlock(block: Block): Void;
    
    /**
     * Remove a block from the list of blocks keyed by type.
     *
     * @param block Block to remove.
     */
    function removeTypedBlock(block: Block): Void;

    /**
     * Finds the blocks with the associated type and returns them. Blocks are
     * optionally sorted by position; top to bottom (with slight LTR or RTL bias).
     *
     * @param type The type of block to search for.
     * @param ordered Sort the list if true.
     * @returns The blocks of the given type.
     */
    function getBlocksByType(type: String, ?ordered: Bool): Array<Block>;

    /**
     * Adds a comment to the list of top comments.
     *
     * @param comment comment to add.
     * @internal
     */
    function addTopComment(comment: WorkspaceComment): Void;

    /**
     * Removes a comment from the list of top comments.
     *
     * @param comment comment to remove.
     * @internal
     */
    function removeTopComment(comment: WorkspaceComment): Void;

    /**
     * Finds the top-level comments and returns them.  Comments are optionally
     * sorted by position; top to bottom (with slight LTR or RTL bias).
     *
     * @param ordered Sort the list if true.
     * @returns The top-level comment objects.
     * @internal
     */
    function getTopComments(?ordered: Bool): Array<WorkspaceComment>;

    /**
     * Find all blocks in workspace.  Blocks are optionally sorted
     * by position; top to bottom (with slight LTR or RTL bias).
     *
     * @param ordered Sort the list if true.
     * @returns Array of blocks.
     */
    function getAllBlocks(?ordered: Bool): Array<Block>;

    /** Dispose of all blocks and comments in workspace. */
    function clear(): Void;

    /**
     * Returns the horizontal offset of the workspace.
     * Intended for LTR/RTL compatibility in XML.
     * Not relevant for a headless workspace.
     *
     * @returns Width.
     */
    function getWidth(): Float;

    /**
     * Obtain a newly created block.
     *
     * @param prototypeName Name of the language object containing type-specific
     *     functions for this block.
     * @param opt_id Optional ID.  Use this ID if provided, otherwise create a new
     *     ID.
     * @returns The created block.
     */
    function newBlock(prototypeName: String, ?opt_id: String): Block;

    /**
     * Obtain a newly created comment.
     *
     * @param id Optional ID.  Use this ID if provided, otherwise create a new
     *     ID.
     * @returns The created comment.
     */
    function newComment(?id: String): WorkspaceComment;

    /**
     * The number of blocks that may be added to the workspace before reaching
     *     the maxBlocks.
     *
     * @returns Number of blocks left.
     */
    function remainingCapacity(): Int;

    /**
     * The number of blocks of the given type that may be added to the workspace
     *    before reaching the maxInstances allowed for that type.
     *
     * @param type Type of block to return capacity for.
     * @returns Number of blocks of type left.
     */
    function remainingCapacityOfType(type: String): Int;

    /**
     * Check if there is remaining capacity for blocks of the given counts to be
     *    created. If the total number of blocks represented by the map is more
     * than the total remaining capacity, it returns false. If a type count is
     * more than the remaining capacity for that type, it returns false.
     *
     * @param typeCountsMap A map of types to counts (usually representing blocks
     *     to be created).
     * @returns True if there is capacity for the given map, false otherwise.
     */
    function isCapacityAvailable(typeCountsMap: Map<String, Int>): Bool;

    /**
     * Checks if the workspace has any limits on the maximum number of blocks,
     *    or the maximum number of blocks of specific types.
     *
     * @returns True if it has block limits, false otherwise.
     */
    function hasBlockLimits(): Bool;
    
    /**
     * Undo or redo the previous action.
     *
     * @param redo False if undo, true if redo.
     */
    function undo(?redo: Bool): Void;

    /**
     * Redoes the previous action.
     */
    function redo(): Void;

    /** Clear the undo/redo stacks. */
    function clearUndo(): Void;

    /**
     * When something in this workspace changes, call a function.
     * Note that there may be a few recent events already on the stack.  Thus the
     * new change listener might be called with events that occurred a few
     * milliseconds before the change listener was added.
     *
     * @param func Function to call.
     * @returns Obsolete return value, ignore.
     */
    function addChangeListener(func: (e: AbstractEvent) -> Void): (e: AbstractEvent) -> Void;

    /**
     * Stop listening for this workspace's changes.
     *
     * @param func Function to stop calling.
     */
    function removeChangeListener(func: (e: AbstractEvent) -> Void): Void;

    /**
     * Fire a change event.
     *
     * @param event Event to fire.
     */
    function fireChangeListener(event: AbstractEvent): Void;

    /**
     * Find the block on this workspace with the specified ID.
     *
     * @param id ID of block to find.
     * @returns The sought after block, or null if not found.
     */
    function getBlockById(id: String): Null<Block>;

    /**
     * Find the comment on this workspace with the specified ID.
     *
     * @param id ID of comment to find.
     * @returns The sought after comment, or null if not found.
     */
    function getCommentById(id: String): Null<WorkspaceComment>;

    /**
     * Checks whether all value and statement inputs in the workspace are filled
     * with blocks.
     *
     * @param opt_shadowBlocksAreFilled An optional argument controlling whether
     *     shadow blocks are counted as filled. Defaults to true.
     * @returns True if all inputs are filled, false otherwise.
     */
    function allInputsFilled(?opt_shadowBlocksAreFilled: Bool): Bool;

    // NOTE: Variable maps are not currently implemented in Haxe
    // NOTE: Procedure maps are not currently implemented in Haxe

    /**
     * Returns the root workspace of this workspace if the workspace has
     * parent(s).
     *
     * E.g. workspaces in flyouts and mini workspace bubbles have parent
     * workspaces.
     */
    function getRootWorkspace(): Null<Workspace>;

    /**
     * Find the workspace with the specified ID.
     *
     * @param id ID of workspace to find.
     * @returns The sought after workspace or null if not found.
     */
    static function getById(id: String): Null<Workspace>;

    /**
     * Find all workspaces.
     *
     * @returns Array of workspaces.
     */
    static function getAll(): Array<Workspace>;

    /**
     * Returns whether or not this workspace is in readonly mode.
     *
     * @returns True if the workspace is readonly, otherwise false.
     */
    function isReadOnly(): Bool;

    /**
     * Sets whether or not this workspace is in readonly mode.
     *
     * @param readOnly True to make the workspace readonly, otherwise false.
     */
    function setIsReadOnly(readOnly: Bool): Void;
}
