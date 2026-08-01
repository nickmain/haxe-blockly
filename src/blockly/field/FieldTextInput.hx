package blockly.field;

import blockly.field.FieldInput.FieldInputValidator;
import blockly.field.FieldInput.FieldInputConfig;

/**
 * Class for an editable text field.
 */
@:native("Blockly.FieldTextInput")
extern class FieldTextInput extends FieldInput<String> {
    /**
     * @param value The initial value of the field. Should cast to a string.
     *     Defaults to an empty string if null or undefined. Also accepts
     *     Field.SKIP_SETUP if you wish to skip setup (only used by subclasses
     *     that want to handle configuration and setting the field value after
     *     their own constructors have run).
     * @param validator A function that is called to validate changes to the
     *     field's value. Takes in a string & returns a validated string, or null
     *     to abort the change.
     * @param config A map of options used to configure the field.
     *     See the [field creation documentation]{@link
     * https://developers.google.com/blockly/guides/create-custom-blocks/fields/built-in-fields/text-input#creation}
     * for a list of properties this parameter supports.
     */
    function new(?value: String /*| typeof Field.SKIP_SETUP */, ?validator: Null<FieldTextInputValidator>, ?config: FieldTextInputConfig);
    
    /**
     * Construct a FieldTextInput from a JSON arg object,
     * dereferencing any string table references.
     *
     * @param options A JSON object with options (text, and spellcheck).
     * @returns The new field instance.
     * @nocollapse
     * @internal
     */
    static function fromJson(options: FieldTextInputFromJsonConfig): FieldTextInput;

    /**
     * Gets an ARIA-friendly label representation of this field's type.
     *
     * Implementations are responsible for, and encouraged to, return a localized
     * version of the ARIA representation of the field's type.
     *
     * @returns An ARIA representation of the field's type or a default if it is
     *     unspecified.
     */
    function getAriaTypeName(): Null<String>;
}

/**
 *  Config options for the text input field.
 */
typedef FieldTextInputConfig = FieldInputConfig;

/**
 * fromJson config options for the text input field.
 */
typedef FieldTextInputFromJsonConfig = FieldTextInputConfig & {
    var ?text: String;
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
typedef FieldTextInputValidator = FieldInputValidator<String>;
