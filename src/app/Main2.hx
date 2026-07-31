package app;

// import blockly.Blockly;
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
                    ToolboxItem.block("controls_if"),
                ], "#881100")
            ]
        }

        final workspace = Blockly.inject("blocklyDiv", {
            toolbox: toolbox,
            toolboxPosition: End,
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

        workspace.registerButtonCallback("wazoo", function(button) {
            trace("Button clicked: " + button.getButtonText());
        });

        workspace.addChangeListener(function(event) {
            if (event.type == EventType.BLOCK_CREATE) {
                final createEvent: BlockCreate = cast event;
                trace('Created: ${createEvent.blockId}');

                final block = workspace.getBlockById(createEvent.blockId);
                // trace(block);
                final textInput = block?.getInput("TEXT");
                if (textInput?.getShadowDom() == null) {
                    textInput?.connection.setShadowState({
                        type: "text",
                        fields: { "TEXT": "Hello" }
                    });
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