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
    mutation: Null<Dynamic>,
    editable: Bool,
    movable: Bool,
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
    public static function serializeBlock(block: BlockModel): Xml {
        //TODO
    }

}