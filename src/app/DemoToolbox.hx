package app;

import blockly.model.ToolboxS12;
import blockly.model.ToolboxS12.Toolbox;

class DemoToolbox {
    static var toolbox: Toolbox = TreeToolbox([
        Category("Logic", "210", [
            Category("Baz Bat", "#ffff00", [], [
                Block(BlockType("controls_if")),
                Block(BlockType("controls_repeat_ext")),
                Block(BlockType("math_number")),
                Block(BlockType("math_arithmetic"))
            ])
        ], [
            Block(BlockType("controls_if")),
            Block(BlockType("logic_compare")),
            Block(BlockType("logic_operation")),
            Block(BlockType("logic_negate")),
            Gap(45),
            Block(BlockType("logic_boolean")),
            Block(BlockType("logic_null")),
            Block(BlockType("logic_ternary"))
        ]),
        Separator,
        Category("Foo Bar", "140", [], [
            Button("Configure ..."),
            Block(BlockMin("app.blocks.FooBarBlock", [
                ValueInput("inp1", null, BlockType("app.blocks.DemoQuestions"))], null)),
            Block(BlockType("app.blocks.DemoQuestions")),
            Block(BlockType("app.blocks.KitchenSink")),
            Block(BlockType("text")),
            Block(BlockMin("text_print", [
                ValueInput("TEXT", null, BlockMin("text", null, [{name: "TEXT", value: "abcd" }]))], null))
        ]),
    ]);

    public static function toXml(): Xml {
        return ToolboxS12.serialize(toolbox);
    }

    public static function toString(): String {
        return toXml().toString();
    }
}
