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
    comment: Null<Comment>,
    next: Null<BlockModel>,
    data: Null<String>,
    inputs: Null<Array<InputModel>>,
    fields: Null<Array<FieldModel>>
}

typedef Comment = { text: String, pinned: Bool, w: Int, h: Int }

enum InputModel {
    ValueInput(name: String, block: Null<BlockModel>, shadow: Null<BlockModel>);
    Statement(name: String, block: Null<BlockModel>);
}

typedef FieldModel = { name: String, value: String }

class WorkspaceS12 {

    // TODO: deserialize workspace

    public static function deserializeWorkspace(xml: Xml): Workspace {
        var blocks: Array<TopBlock> = [];

        // don't actually care what the container element is
        for(elem in xml.elements()) {
            var block = deserializeBlock(elem);
            var xattr = elem.get("x");
            var x = (xattr != null) ? Std.parseInt(xattr) : 0;
            var yattr = elem.get("y");
            var y = (yattr != null) ? Std.parseInt(yattr) : 0;
            blocks.push({x: x, y: y, block: block});
        }

        return { blocks: blocks };
    }

    public static function deserializeBlock(xml: Xml): BlockModel {
        return {
            type     : xml.get("type"),
            id       : xml.get("id"),
            disabled : boolAttrTrue(xml, "disabled"),
            collapsed: boolAttrTrue(xml, "collapsed"),
            mutation : elemNamed(xml, "mutation"),
            editable : boolAttrTrue(xml, "editable"),
            movable  : boolAttrTrue(xml, "movable"),
            inlined  : boolAttrTrue(xml, "inline"),
            deletable: boolAttrTrue(xml, "deletable"),
            comment  : getComment(xml),
            next     : getNext(xml),
            data     : textNamed(xml. "data"),
            inputs: Null<Array<InputModel>>,
            fields: Null<Array<FieldModel>>
        };
    }

    static function getNext(xml: Xml): Null<BlockModel> {
        var elem = elemNamed("next");
        if(elem == null) return null;

        var block = elem.firstElement();
        if(block == null) return null;

        return deserializeBlock(block);
    }

    static function getComment(xml: Xml): Null<Comment> {
        var elem = elemNamed("comment");
        if(elem == null) return null;

        return {
            text  : elem.firstChild().nodeValue,
            pinned: boolAttrTrue(elem, "pinned"),
            w     : intAttr(elem, "w"),
            h     : intAttr(elem, "h")
        };
    }

    // whether bool attr exists and is true or TRUE
    static function boolAttrTrue(xml: Xml, attr: String): Bool {
        var value = xml.get(attr);
        if(attr == null) return false;
        return (attr == "true" || attr == "TRUE");
    }

    static function intAttr(xml: Xml, attr: String): Int {
        var value = xml.get(attr);
        if(value == null) return null;
        var i =  Std.parseInt(value);
        if(i == null) return 0;
        return i;
    }

    static function elemNamed(xml: Xml, name: String): Null<Xml> {
        for(e in xml.elementsNamed(name)) return e;
        return null;
    }

    static function textNamed(xml: Xml, name: String): Null<String> {
        var e = elemNamed(xml, "data");
        if(e == null || e.firstChild() == null) return null;
        return e.firstChild().nodeValue;
    }

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