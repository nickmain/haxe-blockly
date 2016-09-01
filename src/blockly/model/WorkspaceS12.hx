package blockly.model;

/**
 * Serialization models for workspace and block values.
 * S12 = Serialization
 */

typedef Workspace = { blocks: Array<TopBlock> }

typedef TopBlock = { x: Int, y: Int, block: BlockModel }

typedef BlockModel = {
    type: String,
    id: String,   // UUID
    disabled: Bool,
    collapsed: Bool,
    mutation: Null<Xml>,  //node must be named "mutation"
    editable: Bool,
    movable: Bool,
    inlined: Bool,
    deletable: Bool,
    comment: Null<{ text: String, pinned: Bool, w: Int, h: Int }>,
    next: Null<BlockModel>,
    data: Null<String>,
    inputs: Null<Array<InputModel>>,
    fields: Null<Array<FieldModel>>
}

enum InputModel {
    ValueInput(name: String, block: Null<BlockModel>, shadow: Null<BlockModel>);
    Statement(name: String, block: Null<BlockModel>);
}

typedef FieldModel = { name: String, value: String }

class WorkspaceS12 {

    // TODO: deserialize workspace

    /**
     * Serialize workspace to XML
     */
    public static function serializeWorkspace(workspace: Workspace): Xml {
        var root = Xml.createElement("xml");

        for(b in workspace.blocks) {
            var block = serializeBlock(block.block);
            block.set("x", '${b.x}');
            block.set("y", '${b.y}');
            root.addChild(block);
        }

        return root;
    }

    /**
     * Serialize a block to XML
     */
    public static function serializeBlock(block: BlockModel, isShadow: Bool = false): Xml {
        var root = Xml.createElement(isShadow ? "shadow": "block");
        root.set("type", block.type);
        root.set("id", block.id);

        if(block.disabled ) root.set("disabled" , "true");
        if(block.collapsed) root.set("collapsed", "true");
        if(block.editable ) root.set("editable" , "true");
        if(block.movable  ) root.set("movable"  , "true");
        if(block.deletable) root.set("deletable", "true");
        if(block.inlined  ) root.set("inline"   , "true");

        if(block.mutation != null) root.addChild(block.mutation);

        if(block.fields != null) for(f in block.fields) {
            var field = Xml.createElement("field");
            field.set("name", f.name);
            field.addChild(Xml.createPCData(f.value));
            root.addChild(field);
        }

        if(block.comment != null) {
            var comment = Xml.createElement("comment");
            comment.set("pinned", block.comment.pinned ? "true" : "false");
            comment.set("w", '${block.comment.w}');
            comment.set("h", '${block.comment.h}');
            comment.addChild(Xml.createPCData(block.comment.text));
            root.addChild(comment);
        }

        if(block.data != null) {
            var data = Xml.createElement("data");
            data.addChild(Xml.createPCData(block.data));
            root.addChild(data);
        }

        if(block.inputs != null) for(i in block.inputs) {
            switch(i) {
                case ValueInput(name, blk, shadow): {
                    var value = Xml.createElement("value");
                    value.set("name", name);
                    if(shadow != null) value.addChild(serializeBlock(shadow, true));
                    if(blk != null) value.addChild(serializeBlock(blk, false));
                    root.addChild(value);
                }
                case Statement(name, blk): {
                    var statement = Xml.createElement("statement");
                    statement.set("name", name);
                    if(blk != null) statement.addChild(serializeBlock(blk, false));
                    root.addChild(statement);
                }
            }
        }

        if(block.next != null) {
            var next = Xml.createElement("next");
            next.addChild(serializeBlock(block.next));
            root.addChild(next);
        }

        return root;
    }

}