package blockly;

extern class WorkspaceComment {
    final workspace: Workspace;

    /** The unique identifier for this comment. */
    final id: String;

    /**
     * Constructs the comment.
     *
     * @param workspace The workspace to construct the comment in.
     * @param id An optional ID to give to the comment. If not provided, one will
     *     be generated.
     */
    function new(workspace: Workspace, ?id: String);

    /** Sets the text of the comment. */
    function setText(text: String): Void;
    
    /** Returns the text of the comment. */
    function getText(): String;
    
    /** Sets the comment's size in workspace units. */
    function setSize(size: Size): Void;
    
    /** Returns the comment's size in workspace units. */
    function getSize(): Size;

    /** Sets whether the comment is collapsed or not. */
    function setCollapsed(collapsed: Bool): Void;

    /** Returns whether the comment is collapsed or not. */
    function isCollapsed(): Bool;

    /** Sets whether the comment is editable or not. */
    function setEditable(editable: Bool): Void;

    /**
     * Returns whether the comment is editable or not, respecting whether the
     * workspace is read-only.
     */
    function isEditable(): Bool;

    /**
     * Returns whether the comment is editable or not, only examining its own
     * state and ignoring the state of the workspace.
     */
    function isOwnEditable(): Bool;

    /** Sets whether the comment is movable or not. */
    function setMovable(movable: Bool): Void;

    /**
     * Returns whether the comment is movable or not, respecting whether the
     * workspace is read-only.
     */
    function isMovable(): Bool;

    /**
     * Returns whether the comment is movable or not, only examining its own
     * state and ignoring the state of the workspace.
     */
    function isOwnMovable(): Bool;

    /** Sets whether the comment is deletable or not. */
    function setDeletable(deletable: Bool): Void;

    /**
     * Returns whether the comment is deletable or not, respecting whether the
     * workspace is read-only.
     */
    function isDeletable(): Bool;

    /**
     * Returns whether the comment is deletable or not, only examining its own
     * state and ignoring the state of the workspace.
     */
    function isOwnDeletable(): Bool;

    /** Moves the comment to the given location in workspace coordinates. */
    function moveTo(location: Coordinate, ?reason: Null<Array<String>>): Void;

    /** Returns the position of the comment in workspace coordinates. */
    function getRelativeToSurfaceXY(): Coordinate;

    /** Disposes of this comment. */
    function dispose(): Void;

    /** Returns whether the comment has been disposed or not. */
    function isDisposed(): Bool;

    /**
     * Returns true if this comment view is currently being disposed or has
     * already been disposed.
     */
    function isDeadOrDying(): Bool;
}
