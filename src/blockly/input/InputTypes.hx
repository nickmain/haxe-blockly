package blockly.input;

enum abstract InputTypes(Int) {
    var VALUE = 1;
    var STATEMENT = 3;
    var DUMMY = 5;
    var CUSTOM = 6;
    var END_ROW = 7;
}
