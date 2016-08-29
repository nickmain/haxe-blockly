package blockly.model;

/**
 * Definition models for blocks
 */

enum FieldAlignment { Left; Right; Center; }

enum InputDef {
    Dummy(alignment: FieldAlignment, fields: Array<FieldDef>);
    Value(name: String, type: ValueType, alignment: FieldAlignment, fields: Array<FieldDef>);
    Statement(name: String, type: ValueType, alignment: FieldAlignment, fields: Array<FieldDef>);
}

enum FieldDef {
    TextLabel(text: String);
    TextInput(name: String, text: String);
    Angle(name: String, value: Int);
    DropDown(name: String, value: String, options: Array<{value: String, text: String}>);
    Colour(name: String, value: String);
    CheckBox(name: String, value: Bool);
    Variable(name: String, value: String);
    Image(url: String, w: Int, h: Int, alt: String);
    Numeric(name: String, value: String, min: Dynamic, max: Dynamic, precision: Dynamic );
    DateSelect(name: String, value: String);
}

enum ValueType {
    AnyType; BoolType; NumType; StringType; ListType;
    UnionType(types: Array<ValueType>);
    CustomType(name: String);
}

class BlockDef {
    public function new() {
    }
}
