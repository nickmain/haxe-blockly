package blockly;

@:native("Blockly")
extern class Blockly {

    /**
     * Inject a Blockly editor into the specified container element (usually a div).
     * @param {!Element|string} container Containing element or its ID.
     * @param {Object=} opt_options Optional dictionary of options.
     * @return {!Blockly.Workspace} Newly created main workspace.
     */
    @:overload(function(div: js.html.Element, config: BlocklyConfig ): Workspace {})
    @:overload(function(div:String, config: BlocklyConfig ): Workspace {})
    public static function inject(div: js.html.Element, config: BlocklyConfig ): Workspace;

    /**
     * Returns the main workspace.  Returns the last used main workspace (based on focus).
     */
    public static function getMainWorkspace(): Workspace;

    public static var Blocks: Dynamic;

    /**
     * Currently selected block.
     */
    public static var selected: Null<Block>;

    /** Generate a unique id */
    public static function genUid(): String;

    public static var ALIGN_LEFT: Int;
    public static var ALIGN_CENTRE: Int;
    public static var ALIGN_RIGHT: Int;
}
