package blockly;

@:keep
class Grid {
    public function new() {}
    public var spacing: Int = 20;
    public var length: Int = 3;
    public var colour: String = "#ccc";
    public var snap: Bool = true;
}

@:keep
class Zoom {
    public function new() {}
    public var controls: Bool = true;
    public var wheel: Bool = true;
    public var startScale: Float = 1.0;
    public var maxScale: Float = 3;
    public var minScale: Float = 0.3;
    public var scaleSpeed: Float = 1.2;
}

class BlocklyConfig implements Dynamic {
    public function new() {}

    // Path from page (or frame) to the Blockly media directory. Defaults to "https://blockly-demo.appspot.com/static/media/".
    public function setMediaPath(path: String) { this.media = path; return this; }

    // Allows blocks to be collapsed or expanded. Defaults to true if the toolbox has categories, false otherwise.
    public function allowCollapse(allow: Bool) { this.collapse = allow; return this; }

    // Allows blocks to have comments. Defaults to true if the toolbox has categories, false otherwise.
    public function allowComments(allow: Bool) { this.comments = allow; return this; }

    // If false, don't inject CSS (providing CSS becomes the document's responsibility). Defaults to true.
    public function injectCSS(inject:Bool) { this.css = inject; return this; }

    // Allows blocks to be disabled. Defaults to true if the toolbox has categories, false otherwise.
    public function allowDisabling(allow: Bool) { this.disable = allow; return this; }

    // Configures a grid which blocks may snap to
    public function setGrid(grid: Grid) { this.grid = grid; return this; }

    // Maximum number of blocks that may be created. Useful for student exercises. Defaults to Infinity.
    public function setMaxBlocks(max: Int) { this.maxBlocks = max; return this; }

    // If true, prevent the user from editing. Supresses the toolbox and trashcan. Defaults to false.
    public function setReadOnly(ro: Bool) { this.readOnly = ro; return this; }

    // If true, mirror the editor for Arabic or Hebrew locales. Defaults to false.
    public function setRightToLeft(rtl: Bool) { this.rtl = rtl; return this; }

    // Sets whether the workspace is scrollable or not. Defaults to true if the toolbox has categories, false otherwise.
    public function showScrollbars(show: Bool) { this.scrollbars = show; return this; }

    // If false, don't play sounds (e.g. click and delete). Defaults to true.
    public function playSounds(play: Bool) { this.sounds = play; return this; }

    // Displays or hides the trashcan. Defaults to true if the toolbox has categories, false otherwise.
    public function showTrashcan(show: Bool) { this.trashcan = show; return this; }

    // Configures zooming behaviour
    public function setZoom(zoom: Zoom) { this.zoom = zoom; return this; }

    // Tree structure of categories and blocks available to the user.
    public function useToolboxId(id: String) {
        this.toolbox = js.Browser.document.getElementById(id);
        return this;
    }

    // Tree structure of categories and blocks available to the user.
    public function setToolbox(xml: String) {
        this.toolbox = xml;
        return this;
    }
}