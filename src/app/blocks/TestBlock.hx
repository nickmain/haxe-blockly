package app.blocks;

import blockly.field.FieldLabel;
import blockly.event.BlockChange;
import blockly.event.EventType;
import blockly.ContextMenu.SeparatorContextMenuOption;
import blockly.event.AbstractEvent;
import blockly.BlockSvg;

class TestBlock extends blockly.HaxeBlock {
    private final label: FieldLabel;

    public function new(block: BlockSvg) {
        super(block);
        trace("TestBlock constructor");
        block.setColour("#dddd00");
        block.setPreviousStatement(true, null);
        block.setNextStatement(true, null);
        block.setOutput(true, null);
        block.setCommentText("TestBlock - The quick brown fox jumps over the lazy dog.");

        label = new FieldLabel("Test Block");
        block.appendDummyInput()
            .appendField(label);

        block.getSvgRoot()?.classList.add("test-block");
        block.setStyle("test_block_style");
    }

    override public function onChange(event: AbstractEvent) {
        if (event.type == EventType.BLOCK_CHANGE) {
            final changeEvent: BlockChange = cast event;
            trace('${block.id} TestBlock: ${changeEvent.blockId}:${changeEvent.name} ${changeEvent.element} --> ${changeEvent.newValue}');

            if (changeEvent.element == BlockChangeElement.Collapsed) {
                if (changeEvent.newValue == true) {
                    final caption = block.getCommentText() ?? "TestBlock collapsed - The quick brown fox jumps over the lazy dog.";
                    label.setValue(caption);
                    block.setTooltip(caption);
                } else {
                    label.setValue("Test Block");
                    block.setTooltip("Test Block");
                }
            }
        }
        else {
            trace('${block.id} TestBlock onChange: ${event.type}');
        }
    }

    override public function destroy() {
        trace('${block.id} TestBlock destroy');
    }

    override public function customContextMenu(menuOptions: Array<blockly.ContextMenu.ContextMenuOption>) {
        trace('${block.id} TestBlock customContextMenu');
        final separator: SeparatorContextMenuOption = {
            id: "test_block_separator",
            scope: {},
            weight: 1,
            separator: true
        };
        final actionOption: blockly.ContextMenu.ActionContextMenuOption = {
            id: "test_block_action",
            scope: {},
            weight: 2,
            text: "Print block",
            enabled: true,
            callback: function(scope, menuOpenEvent, menuSelectEvent, location) {
                trace(block);
            }
        };
        menuOptions.push(separator);
        menuOptions.push(actionOption);
    }
}
