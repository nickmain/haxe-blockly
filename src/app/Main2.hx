package app;

// import blockly.Blockly;
import blockly.Toolbox.ToolboxItem;
import blockly.Toolbox.ToolboxInfo;
import blockly.Blockly;

class Main2 {

    public function new() {
 
    }
    
    public static function main() {
        final toolbox: ToolboxInfo = {
            kind: Category,            
            contents: [
                ToolboxItem.staticCategory("Logic", [
                    ToolboxItem.block("controls_if"),
                    ToolboxItem.block("logic_compare"),
                    ToolboxItem.block("logic_operation"),
                    ToolboxItem.block("logic_boolean"),
                    ToolboxItem.separator(50),
                    ToolboxItem.label("Hello World"),
                    ToolboxItem.button("Click Me", "wazoo"),
                ], "#008811")
            ]
        }

        final workspace = Blockly.inject("blocklyDiv", {
            toolbox: toolbox,
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
            trace("Workspace changed: " + event.type);
        });
    }
}