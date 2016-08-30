package app.blocks;

import blockly.model.BlockBuilder;
import js.html.XMLHttpRequest;
import js.html.Element;
import blockly.Mutator;
import blockly.Workspace;
import blockly.FieldVariable;
import blockly.FieldDropdown;
import blockly.FieldAngle;
import blockly.Blockly;
import blockly.FieldCheckbox;
import blockly.FieldColour;
import blockly.FieldNumber;
import blockly.FieldTextInput;
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
                LabelledField("A Checkbox", Right, CheckBox("check1", false))
            ]
        });

        block.setCommentText("Everything but the kitchen sink.");

        block.data = "This is some metadata";

        block.setDeletable(true);

        block.setMutator(new Mutator(['controls_if_elseif', 'controls_if_else']));

        appendLabelledField("Text Field", new FieldTextInput("hello"), "text1" ).setAlign(Blockly.ALIGN_RIGHT);
        appendLabelledField("Number Field", new FieldTextInput("1.0", FieldTextInput.numberValidator), "text2" ).setAlign(Blockly.ALIGN_RIGHT);
        appendLabelledField("Int >0 Field", new FieldTextInput("1", FieldTextInput.nonnegativeIntegerValidator), "text3" ).setAlign(Blockly.ALIGN_RIGHT);

        appendLabelledField("Even 0..10", new FieldNumber(2, 0, 10, 2), "numfield" ).setAlign(Blockly.ALIGN_RIGHT);

        appendLabelledField("Angle Field", new FieldAngle("45", FieldAngle.angleValidator), "angle1" );


        appendLabelledField("Colors", new FieldColour( "#ff0000" ), "color1").setAlign(Blockly.ALIGN_RIGHT);
        appendLabelledField("Custom Colors", new FieldColour( "#ffffe0" )
                .setColours(["#ffffe0", "#ffff00", "#ffd700", "#eedd82", "#daa520", "#b8860b"])
                .setColumns(3), "color2")
            .setAlign(Blockly.ALIGN_RIGHT);

       // appendLabelledField("Date Picker", BlocklyApp FieldDate(), "date1").setAlign(Blockly.ALIGN_RIGHT);

        appendLabelledField("Drop Down Menu", new FieldDropdown([["foo","FOO"],["bar","BAR"],["bat","BAT"]]), "menu1").setAlign(Blockly.ALIGN_RIGHT);

        appendLabelledField("Variable", new FieldVariable("foo"), "var1").setAlign(Blockly.ALIGN_RIGHT);

        var checkbox = new FieldCheckbox(false);
        var input1 = block.appendValueInput("input1")
            .appendField(checkbox, "checkX" )
            .setAlign(Blockly.ALIGN_RIGHT);

        checkbox.setValidator(function(checked: Bool) {
            if( checked && input1.connection.targetConnection == null ) {
                var textBlock = block.workspace.newBlock("text");
                input1.connection.connect( textBlock.outputConnection );
                textBlock.setFieldValue("Hello World", "TEXT");
                textBlock.initSvg();
                textBlock.render(true);
            }
            else {
                if( input1.connection.targetBlock() != null ) {
                    input1.connection.targetBlock().setWarningText("Unplugged - discard whenever");
                    input1.connection.targetBlock().warning.setVisible(true);
                    input1.connection.targetBlock().setDisabled(true);
                    input1.connection.targetBlock().unplug(true, true);
                }
            }

            return checked;
        } );
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
        if(hasPrev) block.setPreviousStatement(true);
        if(hasOut) block.setOutput(true);
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
