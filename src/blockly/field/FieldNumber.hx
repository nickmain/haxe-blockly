package blockly.field;

import blockly.field.FieldInput.FieldInputValidator;
import haxe.extern.EitherType;

/**
 * Class for an editable number field.
 */
@:native("Blockly.FieldNumber")
extern class FieldNumber extends FieldInput<Float> {

    /**
     * @param value The initial value of the field. Should cast to a number.
     *     Defaults to 0. Also accepts Field.SKIP_SETUP if you wish to skip setup
     *     (only used by subclasses that want to handle configuration and setting
     *     the field value after their own constructors have run).
     * @param min Minimum value. Will only be used if config is not
     *     provided.
     * @param max Maximum value. Will only be used if config is not
     *     provided.
     * @param precision Precision for value. Will only be used if config
     *     is not provided.
     * @param validator A function that is called to validate changes to the
     *     field's value. Takes in a number & returns a validated number, or null
     *     to abort the change.
     * @param config A map of options used to configure the field.
     *     See the [field creation documentation]{@link
     * https://developers.google.com/blockly/guides/create-custom-blocks/fields/built-in-fields/number#creation}
     * for a list of properties this parameter supports.
     */
    function new(?value: EitherType<String, Float>, 
                 ?min: Null<EitherType<String, Float>>, 
                 ?max: Null<EitherType<String, Float>>, 
                 ?precision: Null<EitherType<String, Float>>, 
                 ?validator: Null<FieldNumberValidator>, 
                 ?config: FieldNumberConfig);

    /**
     * Set the maximum, minimum and precision constraints on this field.
     * Any of these properties may be undefined or NaN to be disabled.
     * Setting precision (usually a power of 10) enforces a minimum step between
     * values. That is, the user's value will rounded to the closest multiple of
     * precision. The least significant digit place is inferred from the
     * precision. Integers values can be enforces by choosing an integer
     * precision.
     *
     * @param min Minimum value.
     * @param max Maximum value.
     * @param precision Precision for value.
     */
    function setConstraints(min: Null<EitherType<String, Float>>, 
                            max: Null<EitherType<String, Float>>, 
                            precision: Null<EitherType<String, Float>>): Void;

    /**
     * Sets the minimum value this field can contain. Updates the value to
     * reflect.
     *
     * @param min Minimum value.
     */
    function setMin(min: Null<EitherType<String, Float>>): Void;

    /**
     * Returns the current minimum value this field can contain. Default is
     * -Infinity.
     *
     * @returns The current minimum value this field can contain.
     */
    function getMin(): Float;

    /**
     * Sets the maximum value this field can contain. Updates the value to
     * reflect.
     *
     * @param max Maximum value.
     */
    function setMax(max: Null<EitherType<String, Float>>): Void;

    /**
     * Returns the current maximum value this field can contain. Default is
     * Infinity.
     *
     * @returns The current maximum value this field can contain.
     */
    function getMax(): Float;

    /**
     * Sets the precision of this field's value, i.e. the number to which the
     * value is rounded. Updates the field to reflect.
     *
     * @param precision The number to which the field's value is rounded.
     */
    function setPrecision(precision: Null<EitherType<Float, String>>): Void;

    /**
     * Returns the current precision of this field. The precision being the
     * number to which the field's value is rounded. A precision of 0 means that
     * the value is not rounded.
     *
     * @returns The number to which this field's value is rounded.
     */
    function getPrecision(): Float;

    /**
     * Construct a FieldNumber from a JSON arg object.
     *
     * @param options A JSON object with options (value, min, max, and precision).
     * @returns The new field instance.
     * @nocollapse
     * @internal
     */
    static function fromJson(options: FieldNumberFromJsonConfig): FieldNumber;
}

/**
 * Config options for the number field.
 */
typedef FieldNumberConfig = FieldInputConfig & {
    var ?min: Float;
    var ?max: Float;
    var ?precision: Float;
}

/**
 * fromJson config options for the number field.
 */
typedef FieldNumberFromJsonConfig = FieldNumberConfig & {
    var ?value: Float;
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
typedef FieldNumberValidator = FieldInputValidator<Float>;
