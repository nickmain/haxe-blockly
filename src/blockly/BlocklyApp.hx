package blockly;

import js.Browser;

/**
 * Various Blockly setup utils
 */
class BlocklyApp {
    var workspace: Workspace;
    var divId: String;

    public function new() {
    }

    /**
     * Inject blockly into the given DIV
     */
    public function inject(divId: String, config: BlocklyConfig) {
        this.divId = divId;
        workspace = Blockly.inject(divId, config);
    }

    /**
     * Add a listener for block selection change events.
     * Call after inject.
     */
    public function addSelectionChangeListener(callback: Void->Void) {
        var blocklyDiv  = Browser.document.getElementById(divId);
        if(blocklyDiv != null) {
            blocklyDiv.addEventListener('blocklySelectChange', function (e) {
                    callback();
                },
                false);
        }
    }

    /**
     * Whether statement blocks with no top input show an "event handler" hat
     */
    public function showStartBlockHats(showHat: Bool) {
        BlockSvg.START_HAT = showHat;
    }

    /**
     * Serialize the current workspace to unformatted XML
     */
    public function workspaceToXML(): String {
        return XMLSerializer.domToText(XMLSerializer.workspaceToDom(workspace));
    }

    /**
     * Serialize the current workspace to pretty XML
     */
    public function workspaceToPrettyXML(): String {
        return XMLSerializer.domToPrettyText(XMLSerializer.workspaceToDom(workspace));
    }

    /**
     * Load blocks from XML
     */
    public function loadWorkspace(xml:String) {
        XMLSerializer.domToWorkspace(workspace, XMLSerializer.textToDom(xml));
    }

    /**
     * Load a block tree from XML and return the root
     */
    public function loadBlock(xml:String): Block {
        return XMLSerializer.domToBlock(workspace, XMLSerializer.textToDom(xml));
    }

    /**
     * Serialize the current workspace to local storage with the given key
     * @return the XML
     */
    public function workspaceToLocalStorage(key:String): String {
        var xml =  XMLSerializer.domToText(XMLSerializer.workspaceToDom(workspace));
        Browser.window.localStorage.setItem(key, xml);
        return xml;
    }

    /**
     * Load the workspace from local storage with the given key.
     * @return false if the key was not found.
     */
    public function loadWorkspaceFromLocalStorage(key: String): Bool {
        var xml = Browser.window.localStorage.getItem(key);
        if(xml == null) return false;
        XMLSerializer.domToWorkspace(workspace, XMLSerializer.textToDom(xml));
        return true;
    }

    /**
     * Register a block type
     */
    public function registerBlock(clazz: Class<CustomBlock>) {
        var blocklyApp = this;
        untyped Blockly.Blocks[Type.getClassName(clazz)] = {
            init: function() {
                untyped __js__("this.haxeBlock = new clazz(this,blocklyApp)");
            },
            validate: function() {
                var haxeBlock: CustomBlock = untyped __js__("this.haxeBlock");
                haxeBlock.validate();
            },
            domToMutation: function(xmlElement) {
                var haxeBlock: CustomBlock = untyped __js__("this.haxeBlock");
                haxeBlock.domToMutation(xmlElement);
            },
            mutationToDom: function() {
                var haxeBlock: CustomBlock = untyped __js__("this.haxeBlock");
                return haxeBlock.mutationToDom();
            },
            decompose: function(workspace) {
                var haxeBlock: CustomBlock = untyped __js__("this.haxeBlock");
                return haxeBlock.decompose(workspace);
            },
            compose: function(containerBlock) {
                var haxeBlock: CustomBlock = untyped __js__("this.haxeBlock");
                haxeBlock.compose(containerBlock);
            },
            onchange: function(event) {
                var haxeBlock: CustomBlock = untyped __js__("this.haxeBlock");
                haxeBlock.onChange(event);
            }
        };
    }
}
