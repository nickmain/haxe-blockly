package app.blocks;

import blockly.FieldCheckbox;
import blockly.FieldLabel;
import blockly.Block;
import blockly.BlocklyApp;
import blockly.CustomBlock;

class FooBarBlock extends CustomBlock {
    public function new(block: Block, application: BlocklyApp) {
        super(block, application);
        trace( "hello world" );
        count = 1;
        block.setColour("#cc88ff");
        block.setPreviousStatement(false);
        block.setNextStatement(true);
        block.setTooltip(function() { return "Hello World !\nThis is going to be interesting\n" + (count++); });

        block.appendDummyInput()
                .appendField( new FieldCheckbox("FALSE"), "check" )
                .appendField("Hello World");
        block.appendStatementInput("stat1");
        block.appendValueInput("inp1")
                .appendField(new FieldLabel("Hello World", "svgDarkText"), null);
    }

    var count = 1;
}
