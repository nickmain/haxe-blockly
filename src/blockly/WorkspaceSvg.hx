package blockly;

extern class FlyoutButton {
    /** @returns Text of the button. */
    function getButtonText(): String;
}

extern class WorkspaceSvg extends Workspace {

    /**
     * Register a callback function associated with a given key, for clicks on
     * buttons and labels in the flyout.
     * For instance, a button specified by the XML
     * <button text="create variable" callbackKey="CREATE_VARIABLE"></button>
     * should be matched by a call to
     * registerButtonCallback("CREATE_VARIABLE", yourCallbackFunction).
     *
     * @param key The name to use to look up this function.
     * @param func The function to call when the given button is clicked.
     */
    function registerButtonCallback(key: String, func: (p1: FlyoutButton) -> Void): Void;

    /**
     * Get the callback function associated with a given key, for clicks on
     * buttons and labels in the flyout.
     *
     * @param key The name to use to look up the function.
     * @returns The function corresponding to the given key for this workspace;
     *     null if no callback is registered.
     */
    function getButtonCallback(key: String): Null<((p1: FlyoutButton) -> Void)>;

    /**
     * Remove a callback for a click on a button in the flyout.
     *
     * @param key The name associated with the callback function.
     */
    function removeButtonCallback(key: String): Void;

    /**
     * Get the workspace theme object.
     *
     * @returns The workspace theme object.
     */
    function getTheme(): Theme;

    /**
     * Set the workspace theme object.
     * If no theme is passed, default to the `Classic` theme.
     *
     * @param theme The workspace theme object.
     */
    function setTheme(theme: Theme): Void;
}