package blockly.event;

/**
 * Abstract class for an event.
 */
extern abstract class AbstractEvent {
    /**
     * Whether or not the event was constructed without necessary parameters
     * (to be populated by fromJson).
     */
    var isBlank: Bool;

    /** The workspace identifier for this event. */
    var workspaceId: Null<String>;

    /**
     * An ID for the group of events this block is associated with.
     *
     * Groups define events that should be treated as an single action from the
     * user's perspective, and should be undone together.
     */
    var group: String;

    /** Whether this event is undoable or not. */
    var recordUndo: Bool;

    /** Whether or not the event is a UI event. */
    var isUiEvent: Bool;

    /** Type of this event. */
    var type: String;

    /**
     * Encode the event as JSON.
     *
     * @returns JSON representation.
     */
    function toJson(): AbstractEventJson;

    /**
     * Does this event record any change of state?
     *
     * @returns True if null, false if something changed.
     */
    function isNull(): Bool;

    /**
     * Run an event.
     *
     * @param _forward True if run forward, false if run backward (undo).
     */
    function run(_forward: Bool): Void;

    /**
     * Get workspace the event belongs to.
     *
     * @returns The workspace the event belongs to.
     * @throws {Error} if workspace is null.
     */
    function getEventWorkspace_(): Workspace;
}

typedef AbstractEventJson = {
    var type: String;
    var group: String;
}
