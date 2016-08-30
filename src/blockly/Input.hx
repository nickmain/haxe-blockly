package blockly;

@:native("Blockly.Input")
extern class Input {

    public var name(default,null): String;

    /**
     * Append a label or Field
     */
    @:overload(function(label: String, name: String = null): Input {})
    @:overload(function(field: Field, name: String = null): Input {})
    public function appendField(label: String, name: String = null): Input;

    /**
     * Remove the field with the given name.
     * Throws if the field is not present.
     */
    public function removeField(name: String): Void;

    /**
     * Whether this input is visible or not.
     */
    public function isVisible(): Bool;

    /**
     * Returns an array of things to be rendered and is probably not safe to call from Haxe
     **/
    public function setVisible(visible: Bool): Array<Block>;

    /**
     * Change a connection's compatibility.
     * @param {string|Array.<string>|null} check Compatible value type or
     *     list of value types.  Null if all types are compatible.
     * @return self
     */
    @:overload(function(check: String): Input {})
    @:overload(function(check: Array<String>): Input {})
    public function setCheck(check: String = null): Input;

    /**
     * Set the alignment of the fields in this input.
     * @param {number} align One of Blockly.ALIGN_LEFT, ALIGN_CENTRE, ALIGN_RIGHT.
     * @return self
     */
    public function setAlign(align: Int): Input;

    /**
     * The connection object for this input
     */
    public var connection: Connection;
}
