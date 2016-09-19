package app;

import js.Browser;
import js.html.Document;
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
        KitchenSink.register(application);

        var blocklyArea = Browser.document.getElementById("blocklyArea");
        var blocklyDiv  = Browser.document.getElementById("blocklyDiv");

        application.inject('blocklyDiv', new BlocklyConfig()
            .setMediaPath("media/")
//            .useToolboxId("toolbox")
            .setToolbox(DemoToolbox.toString())
            .setGrid(new Grid())
            .setZoom(new Zoom())
            .showTrashcan(true)
        );

        var onresize = function(e) {
            // Compute the absolute coordinates and dimensions of blocklyArea.
            var element = blocklyArea;
            var x = 0;
            var y = 0;
            do {
                x += element.offsetLeft;
                y += element.offsetTop;
                element = element.offsetParent;
            } while (element != null);
            // Position blocklyDiv over blocklyArea.
            blocklyDiv.style.left = x + 'px';
            blocklyDiv.style.top = y + 'px';
            blocklyDiv.style.width = blocklyArea.offsetWidth + 'px';
            blocklyDiv.style.height = blocklyArea.offsetHeight + 'px';
        };
        Browser.window.addEventListener('resize', onresize, false);
        onresize(null);
        Blockly.svgResize(application.workspace);

        resultArea = Browser.document.getElementById("resultArea");
        application.loadWorkspaceFromLocalStorage("demo");

        application.workspace.addChangeListener(workspaceChanged);
    }

    function workspaceChanged(event: BlocklyEvent) {
        var e: Event = event;
        //trace('workspaceChanged $e');
        application.workspaceToLocalStorage("demo");

        resultArea.innerText = application.workspaceToPrettyXML();
    }

    static var mainApp: Main;
    public static function main() {
        mainApp = new Main();
    }
}