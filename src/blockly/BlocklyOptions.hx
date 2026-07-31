package blockly;

import blockly.Toolbox.Position;
import blockly.Toolbox.ToolboxInfo;
import haxe.extern.EitherType;
import js.html.Element;
import blockly.Theme.ITheme;

typedef GridOptions = {
    var ?colour: String;
    var ?length: Float;
    var ?snap: Bool;
    var ?spacing: Float;
}

typedef MoveOptions = {
    var ?drag: Bool;
    var ?scrollbars: EitherType<Bool, ScrollbarOptions>;
    var ?wheel: Bool;
}

typedef ScrollbarOptions = {
    var ?horizontal: Bool;
    var ?vertical: Bool;
}

typedef ZoomOptions = {
    var ?controls: Bool;
    var ?maxScale: Float;
    var ?minScale: Float;
    var ?pinch: Bool;
    var ?scaleSpeed: Float;
    var ?startScale: Float;
    var ?wheel: Bool;
}

enum abstract ToolboxPosition(String) to String {
    var Start = "start";
    var End = "end";
}

typedef BlocklyOptions = {
    var ?collapse: Bool;
    var ?comments: Bool;
    var ?css: Bool;
    var ?disable: Bool;
    var ?grid: GridOptions;
    var ?horizontalLayout: Bool;
    var ?maxBlocks: Int;
    var ?maxInstances: haxe.DynamicAccess<Int>;
    var ?media: String;
    var ?modalInputs: Bool;
    var ?move: MoveOptions;
    var ?oneBasedIndex: Bool;
    var ?readOnly: Bool;
    var ?renderer: String;
    var ?rendererOverrides: haxe.DynamicAccess<Any>;
    var ?rtl: Bool;
    var ?scrollbars: EitherType<ScrollbarOptions, Bool>;
    var ?sounds: Bool;
    var ?theme: EitherType<Theme, EitherType<String, ITheme>>;
    var ?toolbox: EitherType<String, EitherType<ToolboxInfo, Element>>;
    var ?toolboxPosition: ToolboxPosition;
    var ?trashcan: Bool;
    var ?maxTrashcanContents: Int;
    var ?plugins: haxe.DynamicAccess<Any>;
    var ?zoom: ZoomOptions;
    var ?parentWorkspace: WorkspaceSvg;
}
