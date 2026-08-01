package blockly.field;

import blockly.field.Field.FieldValidator;
import blockly.field.Field.FieldConfig;
import haxe.extern.EitherType;

enum abstract BoolString(String) to String from String {
    var TRUE = "TRUE";
    var FALSE = "FALSE";
}
typedef CheckboxBool = EitherType<BoolString, Bool>;

/**
 * Class for a checkbox field.
 */
@:native("Blockly.FieldCheckbox")
extern class FieldCheckbox extends Field<CheckboxBool> {
    /** Default character for the checkmark. */
    static final CHECK_CHAR: String;

    /**
     * @param value The initial value of the field. Should either be 'TRUE',
     *     'FALSE' or a boolean. Defaults to 'FALSE'. Also accepts
     *     Field.SKIP_SETUP if you wish to skip setup (only used by subclasses
     *     that want to handle configuration and setting the field value after
     *     their own constructors have run).
     * @param validator  A function that is called to validate changes to the
     *     field's value. Takes in a value ('TRUE' or 'FALSE') & returns a
     *     validated value ('TRUE' or 'FALSE'), or null to abort the change.
     * @param config A map of options used to configure the field.
     *     See the [field creation documentation]{@link
     * https://developers.google.com/blockly/guides/create-custom-blocks/fields/built-in-fields/checkbox#creation}
     * for a list of properties this parameter supports.
     */
    function new(?value: CheckboxBool, 
                 ?validator: FieldCheckboxValidator, 
                 ?config: FieldCheckboxConfig);

    /**
     * Set the character used for the check mark.
     *
     * @param character The character to use for the check mark, or null to use
     *     the default.
     */
    function setCheckCharacter(character: Null<String>): Void;

    /**
     * Get the value of this field, either 'TRUE' or 'FALSE'.
     *
     * @returns The value of this field.
     */
    function getValue(): BoolString;

    /**
     * Get the boolean value of this field.
     *
     * @returns The boolean value of this field.
     */
    function getValueBoolean(): Null<Bool>;

    /**
     * Get the text of this field. Used when the block is collapsed.
     *
     * @returns Text representing the value of this field ('true' or 'false').
     */
    function getText(): String;

}
/**
 * Config options for the checkbox field.
 */
typedef FieldCheckboxConfig = FieldConfig & {
    var ?checkCharacter: String;
}
/**
 * fromJson config options for the checkbox field.
 */
typedef FieldCheckboxFromJsonConfig = FieldCheckboxConfig & {
    var ?checked: Bool;
}

/**
 * A function that is called to validate changes to the field's value before
 * they are set.
 *
 * @see {@link https://developers.google.com/blockly/guides/create-custom-blocks/fields/validators#return_values}
 * @param newValue The value to be validated.
 * @returns One of three instructions for setting the new value: `T`, `null`,
 * or `undefined`.
 *
 * - `T` to set this function's returned value instead of `newValue`.
 *
 * - `null` to invoke `doValueInvalid_` and not set a value.
 *
 * - `undefined` to set `newValue` as is.
 */
typedef FieldCheckboxValidator = FieldValidator<CheckboxBool>;
