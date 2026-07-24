package blockly;

@:native("Blockly.FieldTextInput")
extern class FieldTextInput extends Field {

    /**
     * Class for an editable text field.
     * @param {string} text The initial content of the field.
     * @param {Function=} opt_changeHandler An optional function that is called
     *     to validate any constraints on what the user entered.  Takes the BlocklyApp
     *     text as an argument and returns either the accepted text, a replacement
     *     text, or null to abort the change.
     */
    public function new(text: String, opt_changeHandler: String->String = null);

    /**
     * Set whether this field is spellchecked by the browser.
     */
    public function setSpellcheck(check: Bool): Void;

    /**
     * Change handler that validates numbers
     */
    public static var numberValidator: String->String;

    /**
     * Change handler that validates non-negative integers
     */
    public static var nonnegativeIntegerValidator: String->String;
}
