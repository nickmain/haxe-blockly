package blockly;

@:enum
abstract FieldCheckboxValue(String) from String to String {
    var TRUE = "TRUE";
    var FALSE = "FALSE";

    inline public function new(s: String) this = s;

    @:from static public function fromBool(b: Bool) return b ? TRUE : FALSE;
    @:to public function toBool() return this == "TRUE";
}


@:native("Blockly.FieldCheckbox")
extern class FieldCheckbox extends Field {

    /**
     * @param {string} state The initial state of the field ('TRUE' or 'FALSE').
     * @param {Function=} opt_Validator A function that is executed when a BlocklyApp
     *     option is selected.  Its sole argument is the BlocklyApp checkbox state.  If
     *     it returns a value, this becomes the BlocklyApp checkbox state, unless the
     *     value is null, in which case the change is aborted.
     */
    public function new(state: FieldCheckboxValue, opt_Validator: Bool->Bool = null);
}
