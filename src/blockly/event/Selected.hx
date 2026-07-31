package blockly.event;

import blockly.event.AbstractEvent;

/**
 * Class for a selected event.
 * Notifies listeners that a new element has been selected.
 */
extern class Selected extends UiBase {
    /** The id of the last selected selectable element. */
    var oldElementId: Null<String>;

    /**
     * The id of the newly selected selectable element,
     * or undefined if unselected.
     */
    var newElementId: Null<String>;

    /**
     * @param opt_oldElementId The ID of the previously selected element. Null if
     *     no element last selected. Undefined for a blank event.
     * @param opt_newElementId The ID of the selected element. Null if no element
     *     currently selected (deselect). Undefined for a blank event.
     * @param opt_workspaceId The workspace identifier for this event.
     *    Null if no element previously selected. Undefined for a blank event.
     */
    function new(?opt_oldElementId: Null<String>, ?opt_newElementId: Null<String>, ?opt_workspaceId: String);

    /**
     * Encode the event as JSON.
     *
     * @returns JSON representation.
     */
    function toJson(): SelectedJson;

    /**
     * Deserializes the JSON event.
     *
     * @param event The event to append new properties to. Should be a subclass
     *     of Selected, but we can't specify that due to the fact that parameters
     *     to static methods in subclasses must be supertypes of parameters to
     *     static methods in superclasses.
     * @internal
     */
    static function fromJson(json: SelectedJson, workspace: Workspace, ?event: Any): Selected;
}

typedef SelectedJson = AbstractEvent.AbstractEventJson & {
    var ?oldElementId: String;
    var ?newElementId: String;
}
