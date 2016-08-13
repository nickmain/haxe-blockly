package app.blocks;

import blockly.Blockly;
import blockly.FieldCheckbox;
import blockly.Block;
import blockly.BlocklyApp;
import blockly.CustomBlock;

class DemoQuestions extends CustomBlock {
    public function new(block: Block, application: BlocklyApp) {
        super(block, application);

        block.setColour("#ff0000");
        block.setOutput(true);
//        block.setPreviousStatement(true);
//        block.setNextStatement(true);
        block.setTooltip("Some possible choices");

        appendLabelledField("You can choose this", new FieldCheckbox(false, null), "check1" ).setAlign( Blockly.ALIGN_RIGHT );
        appendLabelledField("You can also choose this", new FieldCheckbox(true, null), "check2" ).setAlign( Blockly.ALIGN_RIGHT );
        appendLabelledField("This is another option", new FieldCheckbox(false, null), "check3" ).setAlign( Blockly.ALIGN_RIGHT );
        appendLabelledField("Or you can choose this one", new FieldCheckbox(false, null), "check4" ).setAlign( Blockly.ALIGN_RIGHT );
    }
}
