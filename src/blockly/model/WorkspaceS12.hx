package blockly.model;

/**
 * Serialization models for workspace and block values.
 * S12 = Serialization
 */

typedef WorkspaceS12 = { blocks: Array<TopBlock> }

typedef TopBlock = { x: Int, y: Int, block: BlockS12 }

typedef BlockS12 = {
    type: String,
    id: String,   // UUID
    disabled: Bool,
    collapsed: Bool,
    mutation: Null<Dynamic>,
    editable: Bool,
    movable: Bool,
    deletable: Bool,
    comment: Null<{ text: String, pinned: Bool, w: Int, h: Int }>,
    next: Null<BlockS12>,
    data: Null<String>,
    inputs: Null<Array<InputS12>>,
    fields: Null<Array<FieldS12>>
}

enum InputS12 {
    ValueInput(name: String, block: Null<BlockS12>, shadow: Null<BlockS12>);
    Statement(name: String, block: Null<BlockS12>);
}

typedef FieldS12 = { name: String, value: String }
