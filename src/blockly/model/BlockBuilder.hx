package blockly.model;

import blockly.model.BlockDef.ValueType;
import blockly.model.BlockDef.ConnectionTypes;
import blockly.model.BlockDef.InputDef;
import blockly.model.BlockDef.FieldDef;
import blockly.model.BlockDef.FieldAlignment;
import blockly.model.BlockDef.Validator;

/** Builder of a Block from a BlockDef */
class BlockBuilder {

    var block: Block;

    public function new(block: Block) {
        this.block = block;
    }

    /**
     * Build the entire block
     */
    public function build(def: BlockDef) {
        setConnections(def.connections);

        block.setInputsInline( switch(def.inlining) {
            case Automatic: null;
            case External: false;
            case Internal: true;
        });

        switch(def.colour) {
            case HSVColour(value): block.setColour(value);
            case RGBColour(value): block.setColour(value);
        };

        switch(def.tooltip) {
            case Fixed(tooltip): block.setTooltip(tooltip);
            case Computed(generator): block.setTooltip(generator);
        }

        block.setWarningText(def.warning);
        block.setHelpUrl(def.help);

        addInputs(def.inputs);
        addValidators(def.validators);
    }

    /**
     * Set the connection types for the block
     */
    public function setConnections(connections: Null<ConnectionTypes>) {
        if( connections == null ) {
            block.setPreviousStatement(false);
            block.setNextStatement(false);
            block.setOutput(false);
            return;
        }

        if(connections.topType != null) block.setPreviousStatement(true, typeString(connections.topType));
        else block.setPreviousStatement(false);

        if(connections.bottomType != null) block.setNextStatement(true, typeString(connections.bottomType));
        else block.setNextStatement(false);

        if(connections.outType != null) block.setOutput(true, typeString(connections.outType));
        else block.setOutput(false);
    }

    /**
     * Add validators to fields
     */
    public function addValidators(validators: Array<Validator>) {
        for(v in validators) {
            switch(v) {
                case Callback(fieldName, callback): {
                    var f = block.getField(fieldName);
                    if(f != null) f.setValidator(callback);
                }
                case Clear(fieldName): {
                    var f = block.getField(fieldName);
                    if(f != null) f.setValidator(null);
                }
            }
        }
    }

    /**
     * Add inputs to the block
     */
    public function addInputs(inputs: Array<InputDef>) {
        for(input in inputs) {
            switch(input) {
                case Dummy(name, alignment, fields): {
                    var i = block.appendDummyInput(name);
                    i.setAlign(fieldAlignment(alignment));
                    addFields(i, fields);
                }
                case LabelledField(label, alignment, field): {
                    var field = createField(field);
                    var i = block.appendDummyInput(field.name);
                    i.setAlign(fieldAlignment(alignment));
                    i.appendField(label);
                    i.appendField(field.field, field.name);
                }
                case Value(name, type, alignment, fields): {
                    var i = block.appendValueInput(name);
                    i.setAlign(fieldAlignment(alignment));
                    i.setCheck(typeString(type));
                    addFields(i, fields);
                }
                case Statement(name, type, alignment, fields): {
                    var i = block.appendStatementInput(name);
                    i.setAlign(fieldAlignment(alignment));
                    i.setCheck(typeString(type));
                    addFields(i, fields);
                }
            }
        }
    }

    /**
     * Add fields to an input
     */
    public function addFields(input: Input, fields: Array<FieldDef>) {
        for(field in fields) {
            var f = createField(field);
            input.appendField(f.field, f.name);
        }
    }

    function createField(field: FieldDef): {name: String, field: Field} {
        return switch(field) {
            case Image(url, w, h, alt): {name: null, field: new FieldImage(url, w, h, alt)};
            case CheckBox(name, value): {name: name, field: new FieldCheckbox(value)};
            case TextLabel(text): {name: null, field: new FieldLabel(text)};
            case StyledLabel(text, cssClass): {name: null, field: new FieldLabel(text, cssClass)};
            case TextInput(name, text): {name: name, field: new FieldTextInput(text)};
            case Numeric(name, value, min, max, precision): {name: name, field: new FieldNumber(value, min, max, precision)};
            case Angle(name, value): {name: name, field: new FieldAngle('$value')};
            case Colour(name, value): {name: name, field: new FieldColour(value)};
            case Variable(name, value): {name: name, field: new FieldVariable(value)};
            case DateSelect(name, date): {name: name, field: new FieldDate(date)};

            case DropDown(name, value, options): {
                var f = new FieldDropdown(options);
                if(value != null) f.setValue(value);
                {name: name, field: f};
            }

            case DropDownGen(name, value, generator): {
                var f = new FieldDropdown(generator);
                if(value != null) f.setValue(value);
                {name: name, field: f};
            }

            case CustomColours(name, value, cols, colours): {
                var f = new FieldColour(value);
                f.setColumns(cols);
                f.setColours(colours);
                {name: name, field: f};
            }

            case SpellcheckedTextInput(name, text): {
                var f = new FieldTextInput(text);
                f.setSpellcheck(true);
                {name: name, field: f};
            }
        }
    }

    function fieldAlignment(alignment: FieldAlignment): Int {
        return switch(alignment) {
            case Left: Blockly.ALIGN_LEFT;
            case Right: Blockly.ALIGN_RIGHT;
            case Center: Blockly.ALIGN_CENTRE;
        }
    }

    function typeString(type: ValueType): Dynamic {
        return switch(type) {
            case AnyType:    null;
            case BoolType:   "Boolean";
            case NumType:    "Number";
            case StringType: "String";
            case ListType:   "Array";
            case UnionType(types): [for(t in types) typeString(t) ];
            case CustomType(name): name;
        }
    }
}

