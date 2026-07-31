package blockly.event;

/**
 * Notifies listeners when a block is moved. This could be from one
 * connection to another, or from one location on the workspace to another.
 */
extern class BlockMove extends BlockBase {

    /** The ID of the old parent block. Undefined if it was a top-level block. */
    var oldParentId: Null<String>;

    /**
     * The name of the old input. Undefined if it was a top-level block or the
     * parent's next block.
     */
    var oldInputName: Null<String>;

    /**
     * The old X and Y workspace coordinates of the block if it was a top level
     * block. Undefined if it was not a top level block.
     */
    var oldCoordinate: Null<Coordinate>;

    /** The ID of the new parent block. Undefined if it is a top-level block. */
    var newParentId: Null<String>;

    /**
     * The name of the new input. Undefined if it is a top-level block or the
     * parent's next block.
     */
    var newInputName: Null<String>;

    /**
     * The new X and Y workspace coordinates of the block if it is a top-level
     * block. Undefined if it is not a top level block.
     */
    var newCoordinate: Null<Coordinate>;

    /**
     * An explanation of what this move is for.  Known values include:
     *  'drag' -- A drag operation completed.
     *  'bump' -- Block got bumped away from an invalid connection.
     *  'snap' -- Block got shifted to line up with the grid.
     *  'inbounds' -- Block got pushed back into a non-scrolling workspace.
     *  'connect' -- Block got connected to another block.
     *  'disconnect' -- Block got disconnected from another block.
     *  'create' -- Block created via XML.
     *  'cleanup' -- Workspace aligned top-level blocks.
     * Event merging may create multiple reasons: ['drag', 'bump', 'snap'].
     */
    var reason: Null<Array<String>>;

    /** @param opt_block The moved block.  Undefined for a blank event. */
    function new(?opt_block: Block);

    /**
     * Encode the event as JSON.
     *
     * @returns JSON representation.
     */
    function toJson(): BlockMoveJson;

    /**
     * Deserializes the JSON event.
     *
     * @param event The event to append new properties to. Should be a subclass
     *     of BlockMove, but we can't specify that due to the fact that parameters
     *     to static methods in subclasses must be supertypes of parameters to
     *     static methods in superclasses.
     * @internal
     */
    static function fromJson(json: BlockMoveJson, workspace: Workspace, ?event: Any): BlockMove;
    
    /** Record the block's new location.  Called after the move. */
    function recordNew(): Void;

    /**
     * Set the reason for a move event.
     *
     * @param reason Why is this move happening?  'drag', 'bump', 'snap', ...
     */
    function setReason(reason: Array<String>): Void;

    /**
     * Does this event record any change of state?
     *
     * @returns False if something changed.
     */
    function isNull(): Bool;

    /**
     * Run a move event.
     *
     * @param forward True if run forward, false if run backward (undo).
     */
    function run(forward: Bool): Void;
}

typedef BlockMoveJson = BlockBase.BlockBaseJson & {
    var ?oldParentId: String;
    var ?oldInputName: String;
    var ?oldCoordinate: String;
    var ?newParentId: String;
    var ?newInputName: String;
    var ?newCoordinate: String;
    var ?reason: Array<String>;
    var ?recordUndo: Bool;
}
