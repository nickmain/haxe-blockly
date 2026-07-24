package blockly;

@:native("Blockly.FieldDate")
extern class FieldDate extends Field {

    /**
     * Class for a date input field.
     * @param {string} date The initial date.
     * @param {Function=} opt_changeHandler A function that is executed when a BlocklyApp
     *     date is selected.  Its sole argument is the BlocklyApp date value.  Its
     *     return value becomes the selected date, unless it is undefined, in
     *     which case the BlocklyApp date stands, or it is null, in which case the change
     *     is aborted.
     */
    public function new(date: String = null, opt_changeHandler: String->String = null);
}