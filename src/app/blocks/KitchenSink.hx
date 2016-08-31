package app.blocks;

import blockly.model.BlockBuilder;
import js.html.XMLHttpRequest;
import js.html.Element;
import blockly.Mutator;
import blockly.Workspace;
import blockly.Block;
import blockly.BlocklyApp;
import blockly.CustomBlock;

class KitchenSink extends CustomBlock {

    var hasPrev: Bool = true;
    var hasOut: Bool = true;
    var builder: BlockBuilder;

    public function new(block: Block, application: BlocklyApp) {
        super(block, application);
        builder =  new BlockBuilder(block);

        builder.build({
            connections: { topType: AnyType, bottomType: AnyType, outType: BoolType },
            inlining: Automatic,
            colour  : RGBColour("#009900"),
            tooltip : "All fields except the kitchen sink",
            warning : "There are things yet to do !",
            help    : "http://blog.nickmain.com",
            inputs  : [
                Dummy("toprow", Left, []),
                Dummy("image", Center, [Image("haxe.png", 100, 25, "Haxe Logo")]),
                LabelledField("A Checkbox", Right, CheckBox("check1", false)),
                LabelledField("Text Field", Right, TextInput("text1", "some text")),
                LabelledField("Spellchecked", Right, SpellcheckedTextInput("textspell", "some text")),
                LabelledField("Even 0..10", Right, Numeric("numfield", 2, 0, 10, 2)),
                LabelledField("Angle Field", Left, Angle("angle1", 45)),
                LabelledField("Colour", Right, Colour("color1", "#ffff00")),
                LabelledField("Custom Colours", Right, CustomColours("color2", "#ffd700", 3, ["#ffffe0", "#ffff00", "#ffd700", "#eedd82", "#daa520", "#b8860b"])),
                LabelledField("Drop Down Menu", Right, DropDown("menu1", "BAR", [["foo","FOO"],["bar","BAR"],["bat","BAT"]])),
                LabelledField("Generated Menu", Right, DropDownGen("menu2", null, randomMenu)),
                LabelledField("Variable", Right, Variable("var1", "foo")),
                Value("input1", AnyType, Right, [CheckBox("checkX", false)])
            ],
            validators: [
                Callback("checkX", funkyCheckInput)
            ]
        });

        block.setCommentText("Everything but the kitchen sink.");
        block.data = "This is some metadata";
        block.setDeletable(true);
        block.setMutator(new Mutator(['controls_if_elseif', 'controls_if_else']));
    }

    // handler for the checkbox value input
    function funkyCheckInput(checked: Bool) {
        if(checked) {
            var inputBlock = getInputBlock("input1");
            if(inputBlock == null) {
                inputBlock = attachBlock("input1", "text");
                inputBlock.setFieldValue("Hello World", "TEXT");
            }
        }
        else {
            var inputBlock = detachBlock("input1");
            if(inputBlock != null) {
                inputBlock.setWarningText("Unplugged - discard at your leisure");
                inputBlock.warning.setVisible(true);
                inputBlock.setDisabled(true);
            }
        }

        return checked;
    }

    function randomMenu(): Array<Array<String>> {
        var opts: Array<Array<String>> = [];
        for(i in 0...5) {
            var opt = '# ${Math.round(Math.random()*1000)}';
            opts.push([opt, opt]);
        }

        trace(opts);
        return opts;
    }

    function checkboxChanged(state:Bool): Bool {
        var req = new XMLHttpRequest();
        req.overrideMimeType("text/xml");
        req.open("POST", "http://127.0.0.1:5000/save", true);
        req.send(application.workspaceToPrettyXML());
        return state;
    }

    override public function onChange(event: Dynamic) {
        if(getPreviousBlock() != null) {
            builder.setConnections({ topType: AnyType, bottomType: AnyType, outType: null });

            hasOut = false;
            hasPrev = true;
        }
        else if(getOutputBlock() != null) {
            builder.setConnections({ topType: null, bottomType: AnyType, outType: BoolType });

            hasOut = true;
            hasPrev = false;
        }
        else {
            builder.setConnections({ topType: AnyType, bottomType: AnyType, outType: BoolType });

            hasOut = true;
            hasPrev = true;
        }
    }

    override public function domToMutation(e: Element) {
        hasPrev = e.getAttribute("has_prev") == "true";
        hasOut  = e.getAttribute("has_out") == "true";

        builder.setConnections({ topType: hasPrev ? AnyType : null, bottomType: AnyType, outType: hasOut ? BoolType : null });
    }

    override public function mutationToDom(): Element {
        var container = js.Browser.document.createElement('mutation');
        container.setAttribute("has_prev", ""+hasPrev);
        container.setAttribute("has_out", ""+hasOut);
        return container;
    }

    override public function decompose(workspace: Workspace): Block {
        var containerBlock = workspace.newBlock("app.blocks.FooBarBlock");
        containerBlock.initSvg();
        return containerBlock;
    }

}
