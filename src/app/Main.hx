package app;

import blockly.events.Event;
import js.Browser;
import js.html.Element;
import app.blocks.KitchenSink;
import app.blocks.DemoQuestions;
import blockly.Blockly;
import app.blocks.FooBarBlock;
import blockly.BlocklyConfig;
import blockly.BlocklyApp;

class Main {

    var application: BlocklyApp;
    var resultArea: Element;

    public function new() {
        application = new BlocklyApp();
        //application.showStartBlockHats(true);

        application.registerBlock( FooBarBlock );
        application.registerBlock( DemoQuestions );
        application.registerBlock( KitchenSink );

        application.inject("blocklyArea", new BlocklyConfig()
            .setMediaPath("media/")
            .useToolboxId("toolbox")
            .setGrid(new Grid())
            .setZoom(new Zoom())
            .showTrashcan(true)
        );

        resultArea = Browser.document.getElementById("resultArea");
        application.loadWorkspaceFromLocalStorage("demo");

        Blockly.getMainWorkspace().addChangeListener(workspaceChanged);
    }

    function workspaceChanged(event: BlocklyEvent) {
        var e: Event = event;
        trace('workspaceChanged $e');
        application.workspaceToLocalStorage("demo");

        var xmlText = application.workspaceToPrettyXML();
        resultArea.innerText = xmlText;
    }

    static var mainApp: Main;
    public static function main() {
        mainApp = new Main();
    }
}