package blockly.event;

/**
 * Enum of values for the .type property for event classes (concrete subclasses
 * of Abstract).
 */
enum abstract EventType(String) {
    /** Type of event that creates a block. */
    var BLOCK_CREATE = "create";
    /** Type of event that deletes a block. */
    var BLOCK_DELETE = "delete";
    /** Type of event that changes a block. */
    var BLOCK_CHANGE = "change";
    /**
     * Type of event representing an in-progress change to a field of a
     * block, which is expected to be followed by a block change event.
     */
    var BLOCK_FIELD_INTERMEDIATE_CHANGE = "block_field_intermediate_change";
    /** Type of event that moves a block. */
    var BLOCK_MOVE = "move";
    /** Type of event that creates a variable. */
    var VAR_CREATE = "var_create";
    /** Type of event that deletes a variable. */
    var VAR_DELETE = "var_delete";
    /** Type of event that renames a variable. */
    var VAR_RENAME = "var_rename";
    /** Type of event that changes the type of a variable. */
    var VAR_TYPE_CHANGE = "var_type_change";
    /**
     * Type of generic event that records a UI change.
     *
     * @deprecated Was only ever intended for internal use.
     */
    var UI = "ui";
    /** Type of event that drags a block. */
    var BLOCK_DRAG = "drag";
    /** Type of event that records a change in selected element. */
    var SELECTED = "selected";
    /** Type of event that records a click. */
    var CLICK = "click";
    /** Type of event that records a marker move. */
    var MARKER_MOVE = "marker_move";
    /** Type of event that records a bubble open. */
    var BUBBLE_OPEN = "bubble_open";
    /** Type of event that records a trashcan open. */
    var TRASHCAN_OPEN = "trashcan_open";
    /** Type of event that records a toolbox item select. */
    var TOOLBOX_ITEM_SELECT = "toolbox_item_select";
    /** Type of event that records a theme change. */
    var THEME_CHANGE = "theme_change";
    /** Type of event that records a viewport change. */
    var VIEWPORT_CHANGE = "viewport_change";
    /** Type of event that creates a comment. */
    var COMMENT_CREATE = "comment_create";
    /** Type of event that deletes a comment. */
    var COMMENT_DELETE = "comment_delete";
    /** Type of event that changes a comment. */
    var COMMENT_CHANGE = "comment_change";
    /** Type of event that moves a comment. */
    var COMMENT_MOVE = "comment_move";
    /** Type of event that resizes a comment. */
    var COMMENT_RESIZE = "comment_resize";
    /**  Type of event that drags a comment. */
    var COMMENT_DRAG = "comment_drag";
    /** Type of event that collapses a comment. */
    var COMMENT_COLLAPSE = "comment_collapse";
    /** Type of event that records a workspace load. */
    var FINISHED_LOADING = "finished_loading";
}
