package blockly;

import haxe.extern.EitherType;

typedef BlockStyle = {
    var colourPrimary: String;
    var colourSecondary: String;
    var colourTertiary: String;
    var hat: String;
}

typedef PartialBlockStyle = {
    var ?colourPrimary: String;
    var ?colourSecondary: String;
    var ?colourTertiary: String;
    var ?hat: String;
}

typedef CategoryStyle = {
    var colour: String;
}

typedef ComponentStyle = {
    var ?workspaceBackgroundColour: String;
    var ?toolboxBackgroundColour: String;
    var ?toolboxForegroundColour: String;
    var ?flyoutBackgroundColour: String;
    var ?flyoutForegroundColour: String;
    var ?flyoutOpacity: Float;
    var ?scrollbarColour: String;
    var ?scrollbarOpacity: Float;
    var ?insertionMarkerColour: String;
    var ?insertionMarkerOpacity: Float;
    var ?markerColour: String;
    var ?cursorColour: String;
    var ?selectedGlowColour: String;
    var ?selectedGlowOpacity: Float;
}

typedef FontStyle = {
    var ?family: String;
    var ?weight: String;
    var ?size: Float;
}

interface ITheme {
    var blockStyles: Null<Map<String, PartialBlockStyle>>;
    var categoryStyles: Null<Map<String, CategoryStyle>>;
    var componentStyles: Null<ComponentStyle>;
    var fontStyle: Null<FontStyle>;
    var startHats: Null<Bool>;
    var base: Null<EitherType<String, Theme>>;
    var name: String;
}

@:native("Blockly.Theme")
extern class Theme implements ITheme {
    var name: String;
    var base: Null<EitherType<String, Theme>>;
    
    /** @internal */
    var blockStyles: Map<String, BlockStyle>;

    /** @internal */
    var categoryStyles: Map<String, CategoryStyle>;

    /** @internal */
    var componentStyles: ComponentStyle;

    /** @internal */
    var fontStyle: FontStyle;

    /**
     * Whether or not to add a 'hat' on top of all blocks with no previous or
     * output connections.
     *
     * @internal
     */
    var startHats: Null<Bool>;

    /**
     * @param name Theme name.
     * @param opt_blockStyles A map from style names (strings) to objects with
     *     style attributes for blocks.
     * @param opt_categoryStyles A map from style names (strings) to objects with
     *     style attributes for categories.
     * @param opt_componentStyles A map of Blockly component names to style value.
     */
    function new(name: String, 
                 ?opt_blockStyles: Map<String, PartialBlockStyle>, 
                 ?opt_categoryStyles: Map<String, CategoryStyle>, 
                 ?opt_componentStyles: ComponentStyle);

    /**
     * Gets the class name that identifies this theme.
     *
     * @returns The CSS class name.
     * @internal
     */
    function getClassName(): String;
    
    /**
     * Overrides or adds a style to the blockStyles map.
     *
     * @param blockStyleName The name of the block style.
     * @param blockStyle The block style.
     */
    function setBlockStyle(blockStyleName: String, blockStyle: BlockStyle): Void;

    /**
     * Overrides or adds a style to the categoryStyles map.
     *
     * @param categoryStyleName The name of the category style.
     * @param categoryStyle The category style.
     */
    function setCategoryStyle(categoryStyleName: String, categoryStyle: CategoryStyle): Void;

    /**
     * Gets the style for a given Blockly UI component.  If the style value is a
     * string, we attempt to find the value of any named references.
     *
     * @param componentName The name of the component.
     * @returns The style value.
     */
    function getComponentStyle(componentName: String): Null<String>;

    /**
     * Configure a specific Blockly UI component with a style value.
     *
     * @param componentName The name of the component.
     * @param styleValue The style value.
     */
    function setComponentStyle(componentName: String, styleValue: Any): Void;

    /**
     * Configure a theme's font style.
     *
     * @param fontStyle The font style.
     */
    function setFontStyle(fontStyle: FontStyle): Void;

    /**
     * Configure a theme's start hats.
     *
     * @param startHats True if the theme enables start hats, false otherwise.
     */
    function setStartHats(startHats: Bool): Void;

    /**
     * Define a new Blockly theme.
     *
     * @param name The name of the theme.
     * @param themeObj An object containing theme properties.
     * @returns A new Blockly theme.
     */
    static function defineTheme(name: String, themeObj: ITheme): Theme;
}
