package blockly;

import haxe.extern.EitherType;
import js.html.HtmlElement;
import js.html.Event;

typedef ContextMenuOption = EitherType<ActionContextMenuOption,
                                       SeparatorContextMenuOption>;

/**
 * The actual workspace/block/focused object where the menu is being
 * rendered. This is passed to callback and displayText functions
 * that depend on this information.
 */
typedef Scope = {
    var ?block: BlockSvg;
    var ?workspace: WorkspaceSvg;
    var ?comment: Any; // RenderedWorkspaceComment;
    var ?focusedNode: Any; // IFocusableNode;
}

typedef CoreContextMenuOption = {
    var id: String;
    var scope: Scope;
    var weight: Float;
    var ?associatedKeyboardShortcut: String;
}

/**
 * A representation of a normal, clickable menu item in contextmenu.ts.
 */
typedef ActionContextMenuOption = CoreContextMenuOption & {
    var text: EitherType<String, HtmlElement>;
    var enabled: Bool;
    /**
     * @param scope Object that provides a reference to the thing that had its
     *     context menu opened.
     * @param menuOpenEvent The original event that triggered the context menu to open.
     * @param menuSelectEvent The event that triggered the option being selected.
     * @param location The location in screen coordinates where the menu was opened.
     */
    var callback: (scope: Scope, menuOpenEvent: Event, menuSelectEvent: Event, location: Coordinate) -> Void;
}

typedef SeparatorContextMenuOption = CoreContextMenuOption & {
    var separator: Bool; // == true
}
