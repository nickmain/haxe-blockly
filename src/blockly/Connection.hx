package blockly;

import blockly.input.Input;
import js.html.Element;
import haxe.extern.EitherType;

/**
 * Enum for the type of a connection or input.
 */
enum abstract ConnectionType(Int) {
    var INPUT_VALUE = 1;
    var OUTPUT_VALUE = 2;
    var NEXT_STATEMENT = 3;
    var PREVIOUS_STATEMENT = 4;
}

/**
 * Class for a connection between blocks.
 */
extern class Connection {
    var type: ConnectionType;

    /** Constants for checking whether two connections are compatible. */
    static var CAN_CONNECT: Int;
    static var REASON_SELF_CONNECTION: Int;
    static var REASON_WRONG_TYPE: Int;
    static var REASON_TARGET_NULL: Int;
    static var REASON_CHECKS_FAILED: Int;
    static var REASON_DIFFERENT_WORKSPACES: Int;
    static var REASON_SHADOW_PARENT: Int;
    static var REASON_DRAG_CHECKS_FAILED: Int;
    static var REASON_PREVIOUS_AND_OUTPUT: Int;

    /** Connection this connection connects to.  Null if not connected. */
    var targetConnection: Null<Connection>;

    /** The unique ID of this connection. */
    var id: String;

    /**
     * @param source The block establishing this connection.
     * @param type The type of the connection.
     */
    function new(source: Block, type: ConnectionType);

    /**
     * Get the source block for this connection.
     *
     * @returns The source block.
     */
    function getSourceBlock(): Block;

    /**
     * Does the connection belong to a superior block (higher in the source
     * stack)?
     *
     * @returns True if connection faces down or right.
     */
    function isSuperior(): Bool;

    /**
     * Is the connection connected?
     *
     * @returns True if connection is connected to another connection.
     */
    function isConnected(): Bool;

    /**
     * Get the workspace's connection type checker object.
     *
     * @returns The connection type checker for the source block's workspace.
     * @internal
     */
    function getConnectionChecker(): IConnectionChecker;

    /**
     * Called when an attempted connection fails. NOP by default (i.e. for
     * headless workspaces).
     *
     * @param _superiorConnection Connection that this connection failed to connect
     *     to. The provided connection should be the superior connection.
     * @internal
     */
    function onFailedConnect(_superiorConnection: Connection): Void;

    /**
     * Connect this connection to another connection.
     *
     * @param otherConnection Connection to connect to.
     * @returns Whether the blocks are now connected or not.
     */
    function connect(otherConnection: Connection): Bool;

    /**
     * Disconnect this connection.
     */
    function disconnect(): Void;

    /**
     * Reconnects this connection to the input with the given name on the given
     * block. If there is already a connection connected to that input, that
     * connection is disconnected.
     *
     * @param block The block to connect this connection to.
     * @param inputName The name of the input to connect this connection to.
     * @returns True if this connection was able to connect, false otherwise.
     */
    function reconnect(block: Block, inputName: String): Bool;

     /**
     * Returns the block that this connection connects to.
     *
     * @returns The connected block or null if none is connected.
     */
    function targetBlock(): Null<Block>;

    /**
     * Change a connection's compatibility.
     *
     * @param check Compatible value type or list of value types. Null if all
     *     types are compatible.
     * @returns The connection being modified (to allow chaining).
     */
    function setCheck(check: Null<EitherType<String, Array<String>>>): Connection;

    /**
     * Get a connection's compatibility.
     *
     * @returns List of compatible value types.
     *     Null if all types are compatible.
     */
    function getCheck(): Null<Array<String>>;

    /**
     * Changes the connection's shadow block.
     *
     * @param shadowDom DOM representation of a block or null.
     */
    function setShadowDom(shadowDom: Null<Element>): Void;

    /**
     * Returns the xml representation of the connection's shadow block.
     *
     * @param returnCurrent If true, and the shadow block is currently attached to
     *     this connection, this serializes the state of that block and returns it
     *     (so that field values are correct). Otherwise the saved shadowDom is
     *     just returned.
     * @returns Shadow DOM representation of a block or null.
     */
    function getShadowDom(?returnCurrent: Bool): Null<Element>;

    /**
     * Changes the connection's shadow block.
     *
     * @param shadowState An state represetation of the block or null.
     */
    function setShadowState(shadowState: Null<Block.State>): Void;

    /**
     * Returns the serialized object representation of the connection's shadow
     * block.
     *
     * @param returnCurrent If true, and the shadow block is currently attached to
     *     this connection, this serializes the state of that block and returns it
     *     (so that field values are correct). Otherwise the saved state is just
     *     returned.
     * @returns Serialized object representation of the block, or null.
     */
    function getShadowState(?returnCurrent: Bool): Null<Block.State>;

    /**
     * Find all nearby compatible connections to this connection.
     * Type checking does not apply, since this function is used for bumping.
     *
     * Headless configurations (the default) do not have neighboring connection,
     * and always return an empty list (the default).
     * {@link (RenderedConnection:class).neighbours} overrides this behavior with a list
     * computed from the rendered positioning.
     *
     * @param _maxLimit The maximum radius to another connection.
     * @returns List of connections.
     * @internal
     */
    function neighbours(_maxLimit: Int): Array<Connection>;

    /**
     * Get the parent input of a connection.
     *
     * @returns The input that the connection belongs to or null if no parent
     *     exists.
     * @internal
     */
    function getParentInput(): Null<Input>;

    /**
     * This method returns a String describing this Connection in developer terms
     * (English only). Intended to on be used in console logs and errors.
     *
     * @returns The description.
     */
    function toString(): String;

    /**
     * Returns the connection (starting at the startBlock) which will accept
     * the given connection. This includes compatible connection types and
     * connection checks.
     *
     * @param startBlock The block on which to start the search.
     * @param orphanConnection The connection that is looking for a home.
     * @returns The suitable connection point on the chain of blocks, or null.
     */
    static function getConnectionForOrphanedConnection(startBlock: Block, orphanConnection: Connection): Null<Connection>;
}
