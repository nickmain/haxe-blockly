package blockly.event;

extern class UiBase extends AbstractEvent {
    @:native("workspaceId")
    var workspaceId_: String;

    /**
     * @param opt_workspaceId The workspace identifier for this event.
     *    Undefined for a blank event.
     */
    function new(?opt_workspaceId: String);
}