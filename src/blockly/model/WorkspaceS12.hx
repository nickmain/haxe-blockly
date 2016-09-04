package blockly.model;

/**
 * Serialization models for workspace and block values.
 * S12 = Serialization
 */

import Xml.XmlType;
typedef Workspace = { blocks: Array<TopBlock> }

typedef TopBlock = { x: Int, y: Int, block: BlockModel }

enum BlockModel {
    Block(
        type: String,
        id: Null<String>,   // UUID
        disabled: Bool,
        collapsed: Bool,
        editable: Bool,
        movable: Bool,
        inlined: Bool,
        deletable: Bool,
        mutation: Null<Xml>,  //node must be named "mutation"
        comment: Null<Comment>,
        next: Null<BlockModel>,
        data: Null<String>,
        inputs: Null<Array<InputModel>>,
        fields: Null<Array<FieldModel>>
    );

    BlockType(type: String);
    BlockMin(type: String, inputs: Null<Array<InputModel>>, fields: Null<Array<FieldModel>>);
}

typedef Comment = { text: String, pinned: Bool, w: Int, h: Int }

enum InputModel {
    ValueInput(name: String, block: Null<BlockModel>, shadow: Null<BlockModel>);
    Statement(name: String, block: Null<BlockModel>);
}

typedef FieldModel = { name: String, value: String }

class WorkspaceS12 {

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
        return Block(
            /* type      */ xml.get("type"),
            /* id        */ xml.get("id"),
            /* disabled  */ boolAttr(xml, false, "disabled"),
            /* collapsed */ boolAttr(xml, false, "collapsed"),
            /* editable  */ boolAttr(xml, true,  "editable"),
            /* movable   */ boolAttr(xml, true,  "movable"),
            /* inlined   */ boolAttr(xml, false, "inline"),
            /* deletable */ boolAttr(xml, true,  "deletable"),
            /* mutation  */ elemNamed(xml, "mutation"),
            /* comment   */ getComment(xml),
            /* next      */ getNext(xml),
            /* data      */ textNamed(xml, "data"),
            /* inputs    */ readInputs(xml),
            /* fields    */ readFields(xml)
        );
    }

    static function readInputs(xml: Xml): Array<InputModel> {
        var inputs: Array<InputModel> = [];

        for(input in xml.elementsNamed("value")) {
            var shadowElem = elemNamed(input, "shadow");
            var shadow = (shadowElem != null) ? deserializeBlock(shadowElem) : null;

            var blockElem = elemNamed(input, "block");
            var block = (blockElem != null) ? deserializeBlock(blockElem) : null;

            inputs.push(ValueInput(input.get("name"), block, shadow));
        }

        for(input in xml.elementsNamed("statement")) {
            var blockElem = input.firstElement();
            var block = (blockElem != null) ? deserializeBlock(blockElem) : null;

            inputs.push(Statement(input.get("name"), block));
        }

        return inputs;
    }

    static function readFields(xml: Xml): Array<FieldModel> {
        var fields: Array<FieldModel> = [];

        for(f in xml.elementsNamed("field")) {
            fields.push({name: f.get("name"), value: elemText(f)});
        }

        return fields.length > 0 ? fields : null;
    }

    static function elemText(xml: Xml): String {
        var child = xml.firstChild();
        if(child != null) return child.toString();
        return "";
    }

    static function getNext(xml: Xml): Null<BlockModel> {
        var elem = elemNamed(xml, "next");
        if(elem == null) return null;

        var block = elem.firstElement();
        if(block == null) return null;

        return deserializeBlock(block);
    }

    static function getComment(xml: Xml): Null<Comment> {
        var elem = elemNamed(xml, "comment");
        if(elem == null) return null;

        return {
            text  : elemText(elem),
            pinned: boolAttr(elem, false, "pinned"),
            w     : intAttr(elem, "w"),
            h     : intAttr(elem, "h")
        };
    }

    // get bool attr with default if missing
    static function boolAttr(xml: Xml, defVal: Bool, attr: String): Bool {
        var value = xml.get(attr);
        if(value == null) return defVal;
        return (value == "true" || value == "TRUE");
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
        var e = elemNamed(xml, name);
        if(e == null) return null;
        return elemText(e);
    }

    /**
     * Serialize workspace to XML
     */
    public static function serializeWorkspace(workspace: Workspace): Xml {
        var root = Xml.createElement("xml");

        for(b in workspace.blocks) {
            var block = serializeBlock(b.block);
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

        switch(block) {
            case BlockType(type): return serializeBlock(
                Block(type, null, false, false, true, true, false, true, null, null, null, null, null, null),
                isShadow
            );

            case BlockMin(type, inputs, fields): return serializeBlock(
                Block(type, null, false, false, true, true, false, true, null, null, null, null, inputs, fields),
                isShadow
            );

            case Block(type, id,
                       disabled, collapsed, editable, movable, inlined, deletable,
                       mutation, comment, next, data, inputs, fields): {
                var root = Xml.createElement(isShadow ? "shadow": "block");
                root.set("type", type);

                if(id != null) root.set("id", id);

                if(disabled  ) root.set("disabled" , "true");
                if(collapsed ) root.set("collapsed", "true");
                if(!editable ) root.set("editable" , "false");
                if(!movable  ) root.set("movable"  , "false");
                if(!deletable) root.set("deletable", "false");
                if(inlined   ) root.set("inline"   , "true");

                if(mutation != null) root.addChild(mutation);

                if(fields != null) for(f in fields) {
                    var field = Xml.createElement("field");
                    field.set("name", f.name);
                    field.addChild(Xml.createPCData(f.value));
                    root.addChild(field);
                }

                if(comment != null) {
                    var comElem = Xml.createElement("comment");
                    comElem.set("pinned", comment.pinned ? "true" : "false");
                    comElem.set("w", '${comment.w}');
                    comElem.set("h", '${comment.h}');
                    comElem.addChild(Xml.createPCData(comment.text));
                    root.addChild(comElem);
                }

                if(data != null) {
                    var dataElem = Xml.createElement("data");
                    dataElem.addChild(Xml.createPCData(data));
                    root.addChild(dataElem);
                }

                if(inputs != null) for(i in inputs) {
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

                if(next != null) {
                    var nextElem = Xml.createElement("next");
                    nextElem.addChild(serializeBlock(next));
                    root.addChild(nextElem);
                }

                return root;
            }
        }
    }
}