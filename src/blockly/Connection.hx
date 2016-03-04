package blockly;

@:native("Blockly.Connection")
extern class Connection {

    /**
     * Connect to another connection.
     */
    public function connect(otherConnection: Connection): Void;

    /**
     * Disconnect this connection.
     */
    public function disconnect(): Void;

    /**
     * Returns the block that this connection connects to or null if none is connected.
     */
    public function targetBlock(): Null<Block>;

    /**
     * Connection this connection connects to.  Null if not connected.
     */
    public var targetConnection: Null<Connection>;
}
