package blockly;

@:native("Blockly.FieldNumber")
extern class FieldNumber extends FieldTextInput {

    /**
     * Class for an editable number field.
     * @param {number|string} value The initial content of the field.
     * @param {number|string|undefined} opt_min Minimum value.
     * @param {number|string|undefined} opt_max Maximum value.
     * @param {number|string|undefined} opt_precision Precision for value.
     * @param {Function=} opt_validator An optional function that is called
     *     to validate any constraints on what the user entered.  Takes the new
     *     text as an argument and returns either the accepted text, a replacement
     *     text, or null to abort the change.
     * @extends {Blockly.FieldTextInput}
     * @constructor
     */
    public function new(value: Dynamic, opt_min: Dynamic, opt_max: Dynamic, opt_precision: Dynamic, opt_validator: String->String = null);

    /**
     * Set the maximum, minimum and precision constraints on this field.
     * Any of these properties may be undefiend or NaN to be disabled.
     * Setting precision (usually a power of 10) enforces a minimum step between
     * values. That is, the user's value will rounded to the closest multiple of
     * precision. The least significant digit place is inferred from the precision.
     * Integers values can be enforces by choosing an integer precision.
     * @param {number|string|undefined} min Minimum value.
     * @param {number|string|undefined} max Maximum value.
     * @param {number|string|undefined} precision Precision for value.
     */
    public function setConstraints(min: Dynamic, max: Dynamic, precision: Dynamic): Void;
}
