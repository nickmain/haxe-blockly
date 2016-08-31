package app.blocks;

import blockly.model.BlockBuilder;
import blockly.Block;
import blockly.BlocklyApp;
import blockly.CustomBlock;

class DemoQuestions extends CustomBlock {

    var builder: BlockBuilder;

    public function new(block: Block, application: BlocklyApp) {
        super(block, application);
        builder =  new BlockBuilder(block);

        builder.build({
            connections: { topType: null, bottomType: null, outType: AnyType },
            inlining: Automatic,
            colour  : RGBColour("#ff0000"),
            tooltip : Fixed("Some possible choices"),
            warning : null,
            help    : null,
            inputs  : [
                LabelledField("You can choose this", Right, CheckBox("check1", false)),
                LabelledField("You can also choose this", Right, CheckBox("check2", true)),
                LabelledField("This is another option", Right, CheckBox("check3", false)),
                LabelledField("Or you can choose this one", Right, CheckBox("check4", false))
            ],
            validators: [
                Callback("check1", function(newValue: Bool) {
                    if(newValue) builder.addInputs([LabelledField("Controlled by first checkbox", Right, CheckBox("check5", false))]);
                    else block.removeInput("check5", true);
                    return newValue;
                })
            ]
        });
    }
}
