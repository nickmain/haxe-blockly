package blockly;

import blockly.events.Event.BlocklyEvent;
import js.html.Element;

/**
 * Base for custom blocks
 */
@:keepSub
class CustomBlock {

    var block: Block;
    var application: BlocklyApp;

    public function new(block: Block, application: BlocklyApp) {
        this.block = block;
        this.application = application;
    }

    /**
     * Called when the workspace is being validated
     */
    public function validate() {}

    /**
     * Called when the block is being deserialized from XML to
     * allow custom mutations to be read
     */
    public function domToMutation(xmlElement: Element) {}

    /**
     * Called when the block is being serialized to XML to
     * allow custom mutations to be written
     */
    public function mutationToDom(): Element {
        return null;
    }

    /**
     * Populate the mutator's dialog with this block's components.
     * Called when the mutator pops up
     * @param workspace Mutator's workspace.
     * @return Root block in mutator.
     */
    public function decompose(workspace: Workspace): Block {
        return null;
    }

    /**
     * Reconfigure this block based on the mutator dialog's components.
     * Called whenever the blocks in the mutator popup's workspace change.
     * @param containerBlock Root block in mutator.
     */
    public function compose(containerBlock: Block) {}

    /**
     * Called by the mutator whenever a main workspace change occurs
     * in order to allow the block being mutated to save references to
     * connections related to the mutation. This allows connected blocks
     * to remain associated with inputs that are being moved within the
     * mutator.
     * @param containerBlock Root block in mutator.
     */
    public function saveConnections(containerBlock: Block) {}

    /**
     * Called on each block when the workspace has changed.
     */
    public function onChange(event: BlocklyEvent) {}

    /**
     * Get the previous statement block
     */
    public function getPreviousBlock(): Null<Block> {
        if(block.previousConnection == null ) return null;
        return block.previousConnection.targetBlock();
    }

    /**
     * Get the block receiving the output
     */
    public function getOutputBlock(): Null<Block> {
        if(block.outputConnection == null ) return null;
        return block.outputConnection.targetBlock();
    }

    /**
     * Get the block plugged into the named input - if any
     */
    public function getInputBlock(inputName: String): Null<Block> {
        var input = block.getInput(inputName);
        if(input == null) return null;
        return input.connection.targetBlock();
    }

    /**
     * Create a block of the given type and attach it to the named input
     * @return the new block
     */
    public function attachBlock(inputName: String, blockType: String): Block {
        var input = block.getInput(inputName);
        var newBlock = block.workspace.newBlock(blockType);
        input.connection.connect(newBlock.outputConnection);
        newBlock.initSvg();
        newBlock.render(true);
        return newBlock;
    }

    /**
     * Detach the block attached to the named input - if any - and return it
     */
    public function detachBlock(inputName: String): Null<Block> {
        var otherBlock = getInputBlock(inputName);
        if(otherBlock != null) otherBlock.unplug(true, true);
        return otherBlock;
    }

    /**
     * Get the CustomBlock associated with a Blockly block
     */
    public static function fromBlock(block: Block): Null<CustomBlock> {
        return untyped __js__("block.haxeBlock");
    }

    /**
     * Append a dummy input with a label field and another field.
     * return the input
     */
    function appendLabelledField(label: String, field: Field, fieldName: String, inputName: String = null ): Input {
        return block.appendDummyInput(inputName)
                    .appendField(label)
                    .appendField(field, fieldName);
    }

    /**
     * Append a dummy input with a field.
     * return the input
     */
    function appendField(field: Field, fieldName: String ): Input {
        return block.appendDummyInput().appendField(field, fieldName);
    }
}
