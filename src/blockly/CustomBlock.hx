package blockly;

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
    public function domToMutation(xmlElement: Element) {
    }

    /**
     * Called when the block is being serialized to XML to
     * allow custom mutations to be written
     */
    public function mutationToDom(): Element {
        return null;
    }

    /**
     * Populate the mutator's dialog with this block's components.
     * @param workspace Mutator's workspace.
     * @return Root block in mutator.
     */
    public function decompose(workspace: Workspace): Block {
        return null;
    }

    /**
     * Reconfigure this block based on the mutator dialog's components.
     * @param containerBlock Root block in mutator.
     */
    public function compose(containerBlock: Block) {
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
    function appendLabelledField(label: String, field: Field, fieldName: String ): Input {
        return block.appendDummyInput()
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
