package blockly.field;

import blockly.field.Field.FieldConfig;
import blockly.field.Field.FieldValidator;

typedef FieldInputValidator<T> = FieldValidator<T>;
typedef FieldInputConfig = FieldConfig & {
    var ?spellcheck: Bool;
}

extern abstract class FieldInput<T> extends Field<T> {
    /**
     * Whether the field should consider the whole parent block to be its click
     * target.
     */
    var fullBlockClickTarget_: Bool;

    function initView(): Void;
    function isFullBlockField(): Bool;

    /**
     * Returns the height and width of the field.
     *
     * This should *in general* be the only place render_ gets called from.
     *
     * @returns Height and width.
     */
    function getSize(): Size;

    /**
     * Set whether this field is spellchecked by the browser.
     *
     * @param check True if checked.
     */
    function setSpellcheck(check: Bool): Void;
}