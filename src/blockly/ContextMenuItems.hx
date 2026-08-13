package blockly;

@:native("Blockly.ContextMenuItems")
extern class ContextMenuItems {
/**
 * Option to undo previous action.
 */
   static function registerUndo(): Void;
/**
 * Option to redo previous action.
 */
   static function registerRedo(): Void;
/**
 * Option to clean up blocks.
 */
   static function registerCleanup(): Void;
/**
 * Option to collapse all blocks.
 */
   static function registerCollapse(): Void;
/**
 * Option to expand all blocks.
 */
   static function registerExpand(): Void;
/**
 * Option to delete all blocks.
 */
   static function registerDeleteAll(): Void;
/**
 * Option to duplicate a block.
 */
   static function registerDuplicate(): Void;
/**
 * Option to add or remove block-level comment.
 */
   static function registerComment(): Void;
/**
 * Option to inline variables.
 */
   static function registerInline(): Void;
/**
 * Option to collapse or expand a block.
 */
   static function registerCollapseExpandBlock(): Void;
/**
 * Option to disable or enable a block.
 */
   static function registerDisable(): Void;
/**
 * Option to delete a block.
 */
   static function registerDelete(): Void;
/**
 * Option to open help for a block.
 */
   static function registerHelp(): Void;
/** Registers an option for deleting a workspace comment. */
   static function registerCommentDelete(): Void;
/** Registers an option for duplicating a workspace comment. */
   static function registerCommentDuplicate(): Void;
/** Registers an option for adding a workspace comment to the workspace. */
   static function registerCommentCreate(): Void;
/** Registers all workspace comment related menu items. */
   static function registerCommentOptions(): Void;
/**
 * Registers all default context menu items. This should be called once per
 * instance of ContextMenuRegistry.
 *
 * @internal
 */
   static function registerDefaultOptions(): Void;
}