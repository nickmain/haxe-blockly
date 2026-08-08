package blockly;

import haxe.extern.EitherType;
import blockly.event.AbstractEvent;
import blockly.field.Field;
import blockly.input.Input;
import js.html.Element;

class HaxeBlock {
    public final block: BlockSvg;

    public function new(block: BlockSvg) {
        this.block = block;
        block.customContextMenu = customContextMenu;
    }

    /**
     * Callback for customizing the context menu
     */
    public function customContextMenu(menuOptions: Array<ContextMenu.ContextMenuOption>) {}

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
    public function onChange(event: AbstractEvent) {}

    /**
     * Called on each block when the workspace has changed.
     */
    public function destroy() {}

    /**
     * Get the previous statement block
     */
    public function getPreviousBlock(): Null<Block> {
        if(block.previousConnection == null ) return null;
        return block.previousConnection.targetBlock();
    }

    /**
     * Get the next statement block
     */
    public function getNextBlock(): Null<Block> {
        if(block.nextConnection == null ) return null;
        return block.nextConnection.targetBlock();
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
        return newBlock;
    }

    /**
     * Detach the block attached to the named input - if any - and return it
     */
    public function detachBlock(inputName: String): Null<Block> {
        var otherBlock = getInputBlock(inputName);
        if(otherBlock != null) otherBlock.unplug(true);
        return otherBlock;
    }

    /**
     * Append a dummy input with a label field and another field.
     * return the input
     */
    function appendLabelledField(label: String, field: Field<Any>, fieldName: String, inputName: String = null): Input {
        return block.appendDummyInput(inputName)
                    .appendField(label)
                    .appendField(field, fieldName);
    }

    /**
     * Append a dummy input with a field.
     * return the input
     */
    function appendField(field: Field<Any>, fieldName: String): Input {
        return block.appendDummyInput().appendField(field, fieldName);
    }

    public static function register(clazz: Class<HaxeBlock>) {
        final className = Type.getClassName(clazz);
        untyped Blockly.Blocks[className] = {
            init: function() {
                js.Syntax.code("this.haxeBlock = new clazz(this)");
            },
            validate: function() {
                var haxeBlock: HaxeBlock = js.Syntax.code("this.haxeBlock");
                haxeBlock.validate();
            },
            domToMutation: function(xmlElement) {
                var haxeBlock: HaxeBlock = js.Syntax.code("this.haxeBlock");
                haxeBlock.domToMutation(xmlElement);
            },
            mutationToDom: function() {
                var haxeBlock: HaxeBlock = js.Syntax.code("this.haxeBlock");
                return haxeBlock.mutationToDom();
            },
            decompose: function(workspace) {
                var haxeBlock: HaxeBlock = js.Syntax.code("this.haxeBlock");
                return haxeBlock.decompose(workspace);
            },
            compose: function(containerBlock) {
                var haxeBlock: HaxeBlock = js.Syntax.code("this.haxeBlock");
                haxeBlock.compose(containerBlock);
            },
            saveConnections: function(containerBlock) {
                var haxeBlock: HaxeBlock = js.Syntax.code("this.haxeBlock");
                haxeBlock.saveConnections(containerBlock);
            },
            onchange: function(event) {
                var haxeBlock: HaxeBlock = js.Syntax.code("this.haxeBlock");
                haxeBlock.onChange(event);
            },
            destroy: function() {
                var haxeBlock: HaxeBlock = js.Syntax.code("this.haxeBlock");
                haxeBlock.destroy();
            },
            customContextMenu: function(menuOptions) {
                var haxeBlock: HaxeBlock = js.Syntax.code("this.haxeBlock");
                haxeBlock.customContextMenu(menuOptions);
            }
        };
    }
}