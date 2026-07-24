package blockly;

@:native("Blockly.FieldColour")
extern class FieldColour extends Field {

    /**
     * Class for a colour input field.
     * @param {string} colour The initial colour in '#rrggbb' format.
     * @param {Function=} opt_changeHandler A function that is executed when a BlocklyApp
     *     colour is selected.  Its sole argument is the BlocklyApp colour value.  Its
     *     return value becomes the selected colour, unless it is undefined, in
     *     which case the BlocklyApp colour stands, or it is null, in which case the change
     *     is aborted.
     */
    public function new(colour: String, opt_changeHandler: String->String = null);

    /**
     * Set a custom grid size for this field.
     * @param {number} columns Number of columns for this block,
     *     or 0 to use default (Blockly.FieldColour.COLUMNS).
     * @return self
     */
    public function setColumns(columns: Int): FieldColour;

    /** Default number of grid columns */
    public static var COLUMNS: Int;

    /**
     * Set a custom colour grid for this field.
     * @param {Array.<string>} colours Array of colours for this block,
     *     or null to use default (Blockly.FieldColour.COLOURS).
     * @return self
     */
    public function setColours(colours: Array<String>): FieldColour;

    /** Default color array */
    public static var COLOURS: Array<String>;
}
