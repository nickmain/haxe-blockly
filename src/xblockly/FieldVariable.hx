package blockly;

@:native("Blockly.FieldVariable")
extern class FieldVariable extends FieldDropdown {

    /**
     * Class for a variable's dropdown field.
     * @param {?string} varname The default name for the variable.  If null,
     *     a unique variable name will be generated.
     * @param {Function=} opt_changeHandler A function that is executed when a BlocklyApp
     *     option is selected.  Its sole argument is the BlocklyApp option value.
     */
    public function new(varname: String = null, opt_changeHandler: String->String = null);
}
