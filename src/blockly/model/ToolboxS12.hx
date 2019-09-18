package blockly.model;

import blockly.model.WorkspaceS12.BlockModel;

/**
 * Serialization model for a toolbox
 */

enum Toolbox {
    FlatToolbox(items: Array<Blocks>);
    TreeToolbox(items: Array<Categories>);
}

enum Blocks {
    Block(block: BlockModel);
    Button(text: String);
    Gap(gap: Int);
}

enum Categories {
    Category(name: String, colour: Null<String>, subcategories: Array<Categories>, blocks: Array<Blocks>);
    Separator;
}

class ToolboxS12 {

    // TODO: deserialize ??? - maybe no use cases

    /**
     * Serialize a toolbox to XML
     */
    public static function serialize(toolbox: Toolbox): Xml {
        var root = Xml.createElement("xml");

        switch(toolbox) {
            case FlatToolbox(items): for(item in items) root.addChild(serializeBlocks(item));
            case TreeToolbox(items): for(item in items) root.addChild(serializeCategories(item));
        }

        return root;
    }

    static function serializeBlocks(block: Blocks): Xml {
        return switch(block) {
            case Block(b): WorkspaceS12.serializeBlock(b);
            case Button(text): {
                var button = Xml.createElement("button");
                button.set("text", text);
                button;
            }
            case Gap(gap): {
                var sep = Xml.createElement("sep");
                sep.set("gap", '$gap');
                sep;
            }
        }
    }

    static function serializeCategories(category: Categories): Xml {
        return switch(category) {
            case Separator: Xml.createElement("sep");
            case Category(name, colour, subcategories, blocks): {
                var cat = Xml.createElement("category");
                cat.set("name", name);
                if(colour != null) cat.set("colour", colour);
                for(block in blocks) cat.addChild(serializeBlocks(block));
                for(subcat in subcategories) cat.addChild(serializeCategories(subcat));
                cat;
            }
        }
    }
}