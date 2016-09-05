package app.blocks;

import blockly.Connection;
import blockly.Blockly;
import haxe.Unserializer;
import haxe.Serializer;
import blockly.model.BlockBuilder;
import js.html.XMLHttpRequest;
import js.html.Element;
import blockly.Mutator;
import blockly.Workspace;
import blockly.Block;
import blockly.BlocklyApp;
import blockly.CustomBlock;

class KitchenSink extends CustomBlock {

    static var DEFAULT_COLOR = "#009900";
    var hasPrev: Bool = true;
    var hasOut: Bool = true;
    var extraInputs: Array<String> = [];
    var builder: BlockBuilder;

    // register this block and its mutator blocks
    public static function register(app: BlocklyApp) {
        app.registerBlock( KitchenSink );
        app.registerBlock( KitchenSinkMutator );
        app.registerBlock( KitchenSinkMutatorInput );
    }

    public function new(block: Block, application: BlocklyApp) {
        super(block, application);
        builder =  new BlockBuilder(block);

        builder.build({
            connections: { topType: AnyType, bottomType: AnyType, outType: BoolType },
            inlining: Automatic,
            colour  : RGBColour(DEFAULT_COLOR),
            tooltip : Fixed("All fields except the kitchen sink"),
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
        block.setMutator(new Mutator(['app.blocks.KitchenSinkMutatorInput']));
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

        var color = e.getAttribute("color");
        if(color != null) block.setColour(color);

        var extras = e.getAttribute("extras");
        if(extras != null) {
            var des = new Unserializer(extras);
            extraInputs = des.unserialize();

            var inputNum = 0;
            for(exin in extraInputs) {
                var inp = block.appendValueInput('extra${inputNum++}');
                inp.setAlign(Blockly.ALIGN_RIGHT);
                inp.appendField(exin);
            }
        }
        else {
            extraInputs = [];
        }

        builder.setConnections({ topType: hasPrev ? AnyType : null, bottomType: AnyType, outType: hasOut ? BoolType : null });
    }

    override public function mutationToDom(): Element {
        var container = js.Browser.document.createElement('mutation');
        container.setAttribute("has_prev", ""+hasPrev);
        container.setAttribute("has_out", ""+hasOut);

        if( block.getColour() != DEFAULT_COLOR ) container.setAttribute("color", block.getColour());

        // serialize the extra input labels
        if( extraInputs.length > 0 ) {
            var serializer = new Serializer();
            serializer.serialize(extraInputs);
            container.setAttribute("extras", serializer.toString() );
        }

        return container;
    }

    override public function decompose(workspace: Workspace): Block {
        var containerBlock = workspace.newBlock("app.blocks.KitchenSinkMutator");
        containerBlock.setFieldValue(block.getColour(), "color1");
        containerBlock.initSvg();

        // create blocks to represent the extra inputs
        var lastBlock = containerBlock.nextConnection;
        for(exin in extraInputs) {
            var extraInput = workspace.newBlock("app.blocks.KitchenSinkMutatorInput");
            extraInput.setFieldValue(exin, "label");
            extraInput.initSvg();
            lastBlock.connect(extraInput.previousConnection);
            lastBlock = extraInput.nextConnection;
        }

        return containerBlock;
    }

    override public function compose(container: Block) {
        var color = container.getFieldValue("color1");
        if( color != null && color != block.getColour()) {
            block.setColour(color);
        }

        // regenerate the extra inputs
        extraInputs = [];
        var inputNum = 0;
        while(true) {
            var name = 'extra${inputNum++}';
            var anInput = block.getInput(name);
            if(anInput == null) break;

            block.removeInput(name);
        }

        inputNum = 0;
        var nextBlock = container.nextConnection.targetBlock();
        while(nextBlock != null) {
            var label = nextBlock.getFieldValue("label");
            extraInputs.push(label);

            var name = 'extra${inputNum++}';
            var inp = block.appendValueInput(name);
            inp.setAlign(Blockly.ALIGN_RIGHT);
            inp.appendField(label);

            // reconnect existing target block if any
            var ksim: KitchenSinkMutatorInput = cast nextBlock;
            if(ksim.targetConnection != null) {
                Mutator.reconnect(ksim.targetConnection, this.block, name);
            }

            nextBlock = nextBlock.nextConnection.targetBlock();
        }
    }

    override public function saveConnections(containerBlock: Block) {

        // loop over the mutator blocks and grab the associated target connection in the main workspace
        var inputNum = 0;
        var nextBlock = containerBlock.nextConnection.targetBlock();
        while(nextBlock != null) {
            var inp = block.getInput('extra${inputNum++}');
            if(inp == null) break;

            var ksim: KitchenSinkMutatorInput = cast nextBlock;
            ksim.targetConnection = inp.connection.targetConnection; // save the connection for use in compose
            nextBlock = nextBlock.nextConnection.targetBlock();
        }
    }
}

/** Container block for mutator */
class KitchenSinkMutator extends CustomBlock {
    public function new(block: Block, application: BlocklyApp) {
        super(block, application);
        new BlockBuilder(block).build({
            connections: { topType: null, bottomType: AnyType, outType: null },
            inlining: Automatic,
            colour  : RGBColour("#999900"),
            tooltip : Fixed("Customize the KitchenSink block"),
            warning : null,
            help    : "http://blog.nickmain.com",
            inputs  : [
                LabelledField("Kitchen Sink", Right, Colour("color1", "#ffff00"))
            ],
            validators: []
        });
    }
}

/** Mutator block for adding extra inputs */
class KitchenSinkMutatorInput extends CustomBlock {

    public var targetConnection: Connection; // connected target in main workspace

    public function new(block: Block, application: BlocklyApp) {
        super(block, application);
        new BlockBuilder(block).build({
            connections: { topType: AnyType, bottomType: AnyType, outType: null },
            inlining: Automatic,
            colour  : RGBColour("#009999"),
            tooltip : Fixed("Add an input to the Kitchen Sink"),
            warning : null,
            help    : "http://blog.nickmain.com",
            inputs  : [
                LabelledField("Input", Left, TextInput("label", "LABEL"))
            ],
            validators: []
        });
    }
}