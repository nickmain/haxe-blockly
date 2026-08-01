package blockly.field;

import blockly.field.Field.FieldConfig;

/**
 * Class for a non-editable, non-serializable text field.
 */
@:native("Blockly.FieldLabel")
extern class FieldLabel extends Field<String> {
    function isLabelField(): Bool;

    /**
     * @param value The initial value of the field. Should cast to a string.
     *     Defaults to an empty string if null or undefined. Also accepts
     *     Field.SKIP_SETUP if you wish to skip setup (only used by subclasses
     *     that want to handle configuration and setting the field value after
     *     their own constructors have run).
     * @param textClass Optional CSS class for the field's text.
     * @param config A map of options used to configure the field.
     *    See the [field creation documentation]{@link
     * https://developers.google.com/blockly/guides/create-custom-blocks/fields/built-in-fields/label#creation}
     * for a list of properties this parameter supports.
     */
    function new(?value: String, ?textClass: String, ?config: FieldLabelConfig);
 
    /**
     * Set the CSS class applied to the field's textElement_.
     *
     * @param cssClass The new CSS class name, or null to remove.
     */
    function setClass(cssClass: Null<String>): Void;
}
/**
 * Config options for the label field.
 */
typedef FieldLabelConfig = FieldConfig & {
    @:native("class")
    var ?class_: String;
}
