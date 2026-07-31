package blockly;

import haxe.extern.EitherType;
import js.html.Element;

@:native("Blockly")
extern class Blockly {

    /**
    * Inject a Blockly editor into the specified container element (usually a div).
    *
    * @param container Containing element, or its ID, or a CSS selector.
    * @param opt_options Optional dictionary of options.
    * @returns Newly created main workspace.
    */
    static function inject(container: EitherType<Element, String>, ?opt_options: BlocklyOptions): WorkspaceSvg;

    /**
     * A mapping of block type names to block prototype objects.
    */
    @:native("Blocks")
    static var blocks: haxe.DynamicAccess<Any>;
}
