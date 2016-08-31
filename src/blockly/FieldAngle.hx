package blockly;

@:native("Blockly.FieldAngle")
extern class FieldAngle extends FieldTextInput {

    /**
     * Class for an editable angle field.
     * @param {string} text The initial content of the field.
     * @param {Function=} opt_changeHandler An optional function that is called
     *     to validate any constraints on what the user entered.  Takes the BlocklyApp
     *     text as an argument and returns the accepted text or null to abort
     *     the change.
     */
    public function new(text: String, opt_changeHandler: String->String = null);
}
