package blockly;

import js.html.svg.SVGElement;
import js.html.Event;
import haxe.extern.EitherType;

/**
 * Class for a connection between blocks that may be rendered on screen.
 */
extern class RenderedConnection extends Connection {
    var sourceBlock_: BlockSvg;

    /** Connection this connection connects to.  Null if not connected. */
    @:native("targetConnection")
    var targetRenderedConnection: Null<RenderedConnection>;

    /**
     * @param source The block establishing this connection.
     * @param type The type of the connection.
     */
    function new(source: BlockSvg, type: Connection.ConnectionType);

    /**
     * Get the source block for this connection.
     *
     * @returns The source block.
     */
    function getSourceBlock(): BlockSvg;

    /**
     * Returns the block that this connection connects to.
     *
     * @returns The connected block or null if none is connected.
     */
    function targetBlock(): Null<BlockSvg>;

    /**
     * Returns the distance between this connection and another connection in
     * workspace units.
     *
     * @param otherConnection The other connection to measure the distance to.
     * @returns The distance between connections, in workspace units.
     */
    function distanceFrom(otherConnection: Connection): Float;

    /**
     * Change the connection's coordinates.
     *
     * @param x New absolute x coordinate, in workspace coordinates.
     * @param y New absolute y coordinate, in workspace coordinates.
     * @returns True if the position of the connection in the connection db
     *     was updated.
     */
    function moveTo(x: Float, y: Float): Bool;

    /**
     * Change the connection's coordinates.
     *
     * @param dx Change to x coordinate, in workspace units.
     * @param dy Change to y coordinate, in workspace units.
     * @returns True if the position of the connection in the connection db
     *     was updated.
     */
    function moveBy(dx: Float, dy: Float): Bool;

    /**
     * Move this connection to the location given by its offset within the block
     * and the location of the block's top left corner.
     *
     * @param blockTL The location of the top left corner of the block, in
     *     workspace coordinates.
     * @returns True if the position of the connection in the connection db
     *     was updated.
     */
    function moveToOffset(blockTL: Coordinate): Bool;

    /**
     * Set the offset of this connection relative to the top left of its block.
     *
     * @param x The new relative x, in workspace units.
     * @param y The new relative y, in workspace units.
     */
    function setOffsetInBlock(x: Float, y: Float): Void;

    /**
     * Get the offset of this connection relative to the top left of its block.
     *
     * @returns The offset of the connection.
     */
    function getOffsetInBlock(): Coordinate;

    /**
     * Find the closest compatible connection to this connection.
     * All parameters are in workspace units.
     *
     * @param maxLimit The maximum radius to another connection.
     * @param dxy Offset between this connection's location in the database and
     *     the current location (as a result of dragging).
     * @returns Contains two properties: 'connection' which is either another
     *     connection or null, and 'radius' which is the distance.
     */
    function closest(maxLimit: Float, dxy: Coordinate): {
        connection: Null<RenderedConnection>,
        radius: Float
    };

    /**
     * Sets the aria role and role description for this connection.
     *
     * @param highlightSvg The focusable element for this connection.
     */
    function setAriaRole(highlightSvg: SVGElement): Void;

    /** Add highlighting around this connection. */
    function highlight(): Void;

    /** Remove the highlighting around this connection. */
    function unhighlight(): Void;

    /** Returns true if this connection is highlighted, false otherwise. */
    function isHighlighted(): Bool;

    /**
     * Start tracking this connection, as well as all down-stream connections on
     * any block attached to this connection. This happens when a block is
     * expanded.
     *
     * @returns List of blocks to render.
     */
    function startTrackingAll(): Array<BlockSvg>;

    /**
     * Disconnect two blocks that are connected by this connection.
     *
     * @param setParent Whether to set the parent of the disconnected block or
     *     not, defaults to true.
     *     If you do not set the parent, ensure that a subsequent action does,
     *     otherwise the view and model will be out of sync.
     */
    function disconnectInternal(?setParent: Bool): Void;

    /**
     * Change a connection's compatibility.
     * Rerender blocks as needed.
     *
     * @param check Compatible value type or list of value types. Null if all
     *     types are compatible.
     * @returns The connection being modified (to allow chaining).
     */
    function setCheck(check: Null<EitherType<String, Array<String>>>): RenderedConnection;

    /**
     * Handles showing the context menu when it is opened on a connection.
     * Note that typically the context menu can't be opened with the mouse
     * on a connection, because you can't select a connection. But keyboard
     * users may open the context menu with a keyboard shortcut.
     *
     * @param e Event that triggered the opening of the context menu.
     */
    function showContextMenu(e: Event): Void;    
}

enum abstract TrackedState(Int) {
    var WILL_TRACK = -1;
    var UNTRACKED = 0;
    var TRACKED = 1;
}
