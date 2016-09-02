package blockly;

import haxe.Constraints.Function;
import blockly.events.Event.BlocklyEvent;

@:native("Blockly.Workspace")
extern class Workspace {

    /**
     * Find the workspace with the specified ID.
     */
    public static function getById(id: String): Null<Workspace>;

    /**
     * Add a change callback to the workspace - returns function for remove call
     */
    public function addChangeListener(listener: BlocklyEvent->Void): Function;

    /**
     * Remove a change callback from the workspace
     */
    public function removeChangeListener(listener: Function): Void;

    /**
     * The workspace id
     */
    public var id: String;

    /**
     * Whether right-to-left
     */
    public var RTL: Bool;

    /**
     * Workspace options
     */
    public var options: Dynamic;

    /**
     * Workspaces may be headless.
     * @type {boolean} True if visible.  False if headless.
     */
    public var rendered: Bool;

    /**
     * Dispose of this workspace.
     * Unlink from all DOM elements to prevent memory leaks.
     */
    public function dispose(): Void;

    /**
     * Add a block to the list of top blocks.
     */
    public function addTopBlock(block: Block): Void;

    /**
     * Remove a block from the list of top blocks.
     */
    public function removeTopBlock(block: Block): Void;

    /**
     * Finds the top-level blocks and returns them.  Blocks are optionally sorted
     * by position; top to bottom (with slight LTR or RTL bias).
     */
    public function getTopBlocks(ordered: Bool): Array<Block>;

    /**
     * Find all blocks in workspace.  No particular order.
     */
    public function getAllBlocks(): Array<Block>;

    /**
     * Dispose of all blocks in workspace.
     */
    public function clear(): Void;

    /**
     * Returns the horizontal offset of the workspace.
     * Intended for LTR/RTL compatibility in XML.
     * Not relevant for a headless workspace.
     */
    public function getWidth(): Int;

    /**
     * Finds the block with the specified ID in this workspace.
     */
    public function getBlockById(id: String): Null<Block>;

    /**
     * Obtain a newly created block.
     */
    public function newBlock(prototypeName:String): Block;

    /**
     * Fire a change event
     */
    public function fireChangeEvent(): Void;

    /**
     * Update the toolbox
     */
    @:overload(function(toolXML: js.html.Element): Void {})
    @:overload(function(toolXML: String): Void {})
    public function updateToolbox(toolXML: String): Void;
}
