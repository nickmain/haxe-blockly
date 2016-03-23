package blockly;

@:native("Blockly.Field")
extern class Field {

    public function getValue(): String;
    public function setValue(value: String): Void;

    public function getText(): String;
    public function setText(text: String): Void;

    public function isVisible(): Bool;
    public function setVisible(visible: Bool): Void;

    public function setTooltip(tip: String): Void;

    /**
     * Sets a BlocklyApp change handler for editable fields.
     * @param {Function} handler New change handler, or null.
     */
    public function setValidator(handler: Dynamic->Dynamic = null): Void;
}
