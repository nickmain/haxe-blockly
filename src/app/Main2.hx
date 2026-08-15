package app;

// import blockly.Blockly;
import blockly.model.WorkspaceModel;
import blockly.ContextMenuItems;
import blockly.Coordinate;
import blockly.WorkspaceComment;
import blockly.HaxeBlock;
import blockly.field.FieldLabel;
import blockly.field.FieldCheckbox;
import blockly.event.Selected;
import blockly.event.BlockDelete;
import haxe.macro.Type.EnumType;
import blockly.event.BlockChange;
import blockly.event.BlockMove;
import blockly.event.BlockCreate;
import blockly.event.EventType;
import blockly.Toolbox.ToolboxItem;
import blockly.Toolbox.ToolboxInfo;
import blockly.Blockly;

class Main2 {
    static var showWarnings: Bool = true;

    public function new() {

    }

    public static function main() {
        final textPrintBlock = ToolboxItem.block("text_print");
        textPrintBlock.inputs = {
            "TEXT": {
                shadow: {
                    type: "text",
                    fields: { "TEXT": "Hola!" }
                }
            }
        };

        trace(textPrintBlock);

        final model = new WorkspaceModel();

        final toolbox: ToolboxInfo = {
            kind: Category,
            contents: [
                ToolboxItem.staticCategory("Logic", [
                    ToolboxItem.block("controls_if"),
                    ToolboxItem.block("logic_compare"),
                    ToolboxItem.block("logic_operation"),
                    ToolboxItem.block("logic_boolean"),
                    ToolboxItem.block("text_print"),
                    textPrintBlock,
                    ToolboxItem.block("text"),
                    ToolboxItem.separator(50),
                    ToolboxItem.label("Hello World"),
                    ToolboxItem.button("Click Me", "wazoo"),
                ], "#008811"),
                ToolboxItem.staticCategory("Custom", [
                    ToolboxItem.block("app.blocks.TestBlock"),
                ], "#881100")
            ]
        }

        HaxeBlock.register(app.blocks.TestBlock);

        final workspace = Blockly.inject("blocklyDiv", {
            toolbox: toolbox,
            toolboxPosition: End,
            renderer: "thrasos",
            zoom: {
                controls: true,
                wheel: true,
                startScale: 1.0,
                maxScale: 3,
                minScale: 0.3,
                scaleSpeed: 1.2,
                pinch: true
            }
        });

        ContextMenuItems.registerCommentOptions();

        final currentTheme = workspace.getTheme();

        currentTheme.setBlockStyle('test_block_style', {
            colourPrimary: "#ffff00",
            colourSecondary: "#0000ff",
            colourTertiary: "#ffffff",
            hat: "#ff5722"
        });

        workspace.setTheme(currentTheme);

        trace(currentTheme);

        workspace.registerButtonCallback("wazoo", function(button) {
            trace("Button clicked: " + button.getButtonText());
            for (block in workspace.getTopBlocks()) {
                trace('${showWarnings}');
                if (showWarnings) {
                    block.setWarningText("Button was clicked");
                } else {
                    block.setWarningText(null);
                }
            }
            showWarnings = !showWarnings;
        });

        workspace.addChangeListener(function(event) {
            if (event.type == EventType.BLOCK_CREATE) {
                final createEvent: BlockCreate = cast event;
                trace('Created: ${createEvent.blockId}');

                final block = workspace.getBlockById(createEvent.blockId);
                if (block.type != "text_print") return;

                // trace(block);
                final textInput = block?.getInput("TEXT");
                if (textInput?.getShadowDom() == null) {
                    textInput?.connection.setShadowState({
                        type: "text",
                        fields: { "TEXT": "Hello" }
                    });

                    block.appendEndRowInput("NUNYA");
                    block.appendDummyInput("ENABLED")
                        .appendField(new FieldLabel("Enabled:"))
                        .appendField(new FieldCheckbox(), "CHECK_FIELD");

                    block.inputsInline = false;
                }
            }
            else if (event.type == EventType.BLOCK_MOVE) {
                final moveEvent: BlockMove = cast event;
                trace('Moved ${moveEvent.blockId} from ${moveEvent.oldParentId}:${moveEvent.oldInputName} to ${moveEvent.newParentId}:${moveEvent.newInputName}');
            }
            else if (event.type == EventType.BLOCK_CHANGE) {
                final changeEvent: BlockChange = cast event;
                trace('Change: ${changeEvent.blockId}:${changeEvent.name} ${changeEvent.element} --> ${changeEvent.newValue}');
            }
            else if (event.type == EventType.BLOCK_DELETE) {
                final deleteEvent: BlockDelete = cast event;
                trace('Delete: ${deleteEvent.blockId} ids: ${deleteEvent.ids}');
            }
            else if (event.type == EventType.SELECTED) {
                final selectEvent: Selected = cast event;
                trace('Selected: ${selectEvent.oldElementId} --> ${selectEvent.newElementId}');
            }
        });
    }
}