package blockly.model;

class WorkspaceModel {
    public var toolbox = new ToolboxModel();
    public var blocks = new Map<String, BlockModel>();
    public var toplevelBlocks = new Array<TopLevelBlockModel>();
    public var comments = new Array<WorkspaceCommentModel>();
    public var toolboxOnRight = true;
    public var readOnly= false;

    public function new() {
        // TODO:
    }
}
