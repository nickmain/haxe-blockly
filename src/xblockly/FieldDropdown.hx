package blockly;

@:native("Blockly.FieldDropdown")
extern class FieldDropdown extends Field {

    /**
     * Class for an editable dropdown field.
     * @param {(!Array.<!Array.<string>>|!Function)} menuGenerator An array of options
     *     for a dropdown list, or a function which generates these options.
     * @param {Function=} opt_changeHandler A function that is executed when a BlocklyApp
     *     option is selected, with the newly selected value as its sole argument.
     *     If it returns a value, that value (which must be one of the options) will
     *     become selected in place of the newly selected option, unless the return
     *     value is null, in which case the change is aborted.
     */
    @:overload(function(menuGenerator: Void->Array<Array<String>>, ?opt_changeHandler: String->String = null): FieldDropdown {})
    public function new(menuGenerator: Array<Array<String>>, ?opt_changeHandler: String->String = null);
}
