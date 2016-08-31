package app.blocks;

import blockly.model.BlockBuilder;
import blockly.Block;
import blockly.BlocklyApp;
import blockly.CustomBlock;

class FooBarBlock extends CustomBlock {

    public function new(block: Block, application: BlocklyApp) {
        super(block, application);

        new BlockBuilder(block).build({
            connections: { topType: null, bottomType: AnyType, outType: null },
            inlining: Automatic,
            colour  : RGBColour("#cc88ff"),
            tooltip : Computed(function() { return "Hello World !\nThis is going to be interesting\n" + (count++); }),
            warning : null,
            help    : null,
            inputs  : [
                Dummy("toprow", Left, [CheckBox("check", false), TextLabel("Hello World")]),
                Statement("stat1", AnyType, Left, []),
                Value("inp1", AnyType, Left, [StyledLabel("Hello World", "svgDarkText")])
            ],
            validators: []
        });
    }

    var count = 1;
}
