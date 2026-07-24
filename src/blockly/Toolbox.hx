package blockly;

import js.html.Node;
import utils.Types.OneOf2;
import utils.Types.OneOf5;

enum abstract Position(Int) {
    var TOP = 0;
    var BOTTOM = 1;
    var LEFT = 2;
    var RIGHT = 3;
}

class ToolboxItem {
    public static function block(type: String): BlockInfo {
        return { kind: BlockInfoKind.Kind, type: type }
    }

    public static function staticCategory(
        name: String, 
        contents: Array<ToolboxItemInfo>,
        ?colour: String
    ): StaticCategoryInfo {
        return { 
            kind: StaticCategoryInfoKind.Kind, 
            name: name, 
            colour: colour,
            contents: contents
        }
    }

    public static function separator(?gap: Float): SeparatorInfo {
        return { kind: SeparatorInfoKind.Kind, gap: gap }
    }

    public static function label(text: String): LabelInfo {
        return { kind: LabelInfoKind.Kind, text: text }
    }

    public static function button(text: String, callbackkey: String): ButtonInfo {
        return { kind: ButtonInfoKind.Kind, text: text, callbackkey: callbackkey }
    }
}

enum abstract ToolboxKind(String) {
    var Flyout = "flyoutToolbox";
    var Category = "categoryToolbox";
}

/**
 * The information needed to create a block in the toolbox.
 * Note that disabled has a different type for backwards compatibility.
 */
typedef BlockInfo = {
    var kind: BlockInfoKind;
    var ?blockxml: OneOf2<String, Node>;
    var ?type: String;
    var ?gap: OneOf2<String, Float>;
    var ?disabled: OneOf2<String, Bool>;
    var ?disabledReasons: Array<String>;
    var ?enabled: Bool;
    var ?id: String;
    var ?collapsed: Bool;
    @:native("inline") var ?_inline: Bool;
    var ?data: String;
    var ?extraState: Any;
    var ?icons: Map<String, Any>;
    var ?fields: Map<String, Any>;
    var ?inputs: Map<String, Block.ConnectionState>;
    var ?next: Block.ConnectionState;
}
enum abstract BlockInfoKind(String) {
    var Kind = "block";
}

typedef SeparatorCssConfig = {
    var ?container: String;
}

/**
 * The information needed to create a separator in the toolbox.
 */
typedef SeparatorInfo = {
    var kind: SeparatorInfoKind;
    var ?id: String;
    var ?gap: Float;
    var ?cssconfig: SeparatorCssConfig;
}
enum abstract SeparatorInfoKind(String) {
    var Kind = "sep";
}

/**
 * The information needed to create a button in the toolbox.
 */
typedef ButtonInfo = {
    var kind: ButtonInfoKind;
    var text: String;
    var callbackkey: String;
}
enum abstract ButtonInfoKind(String) {
    var Kind = "button";
}

/**
 * The information needed to create a label in the toolbox.
 */
typedef LabelInfo = {
    var kind: LabelInfoKind;
    var text: String;
    var ?id: String;
}
enum abstract LabelInfoKind(String) {
    var Kind = "label";
}

/**
 * The information needed to create a category in the toolbox.
 */
typedef StaticCategoryInfo = {
    var kind: StaticCategoryInfoKind;
    var name: String;
    var contents: Array<ToolboxItemInfo>;
    var ?id: String;
    var ?categorystyle: String;
    var ?colour: String;
    var ?cssconfig: CategoryCssConfig;
    var ?hidden: String;
    var ?expanded: OneOf2<String, Bool>;
}
enum abstract StaticCategoryInfoKind(String) {
    var Kind = "category";
}

 /** All the CSS class names that are used to create a category. */
typedef CategoryCssConfig = {
    var ?container: String;
    var ?row: String;
    var ?rowcontentcontainer: String;
    var ?icon: String;
    var ?label: String;
    var ?contents: String;
    var ?selected: String;
    var ?openicon: String;
    var ?closedicon: String;
}

/**
 * The information needed to create a custom category.
 */
typedef DynamicCategoryInfo = {
    var kind: String;
    var custom: String;
    var ?id: String;
    var ?categorystyle: String;
    var ?colour: String;
    var ?cssconfig: CategoryCssConfig;
    var ?hidden: String;
    var ?expanded: OneOf2<String, Bool>;
}

/**
 * All the different types that can be displayed in a flyout.
 */
typedef FlyoutItemInfo = OneOf5<BlockInfo, SeparatorInfo, ButtonInfo, LabelInfo, DynamicCategoryInfo>;

/**
 * Any information that can be used to create an item in the toolbox.
 */
typedef ToolboxItemInfo = OneOf2<FlyoutItemInfo, StaticCategoryInfo>;

typedef ToolboxInfo = {
    var ?kind: ToolboxKind;
    var ?contents: Array<ToolboxItemInfo>;
}
