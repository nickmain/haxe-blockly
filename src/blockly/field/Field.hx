package blockly.field;

import blockly.input.Input;
import js.html.Event;
import js.html.svg.SVGElement;
import js.html.Element;

/**
 * A function that is called to validate changes to the field's value before
 * they are set.
 *
 * @see {@link https://developers.google.com/blockly/guides/create-custom-blocks/fields/validators#return_values}
 * @param newValue The value to be validated.
 * @returns One of three instructions for setting the new value: `T`, `null`,
 * or `undefined`.
 *
 * - `T` to set this function's returned value instead of `newValue`.
 *
 * - `null` to invoke `doValueInvalid_` and not set a value.
 *
 * - `undefined` to set `newValue` as is.
 */
typedef FieldValidator<T> = (newValue: T) -> Null<T>;

/**
 * Extra configuration options for the base field.
 */
typedef FieldConfig = {
    var ?tooltip: String;
    var ?ariaTypeName: String;
}

/**
 * Represents an object that has all the prototype properties of the `Field`
 * class. This is necessary because constructors can change
 * in descendants, though they should contain all of Field's prototype methods.
 *
 * This type should only be used in places where we directly access the prototype
 * of a Field class or subclass.
 */
typedef FieldProto = {};

/**
 * Abstract class for an editable field.
 *
 * @template T - The value stored on the field.
 */
extern abstract class Field<T> {
    /**
     * To overwrite the default value which is set in **Field**, directly update
     * the prototype.
     *
     * Example:
     * `FieldImage.prototype.DEFAULT_VALUE = null;`
     */
    var DEFAULT_VALUE: Null<T>;

    /** Non-breaking space. */
    static final NBSP: String;

    /**
     * A value used to signal when a field's constructor should *not* set the
     * field's value or run configure_, and should allow a subclass to do that
     * instead.
     */
    static final SKIP_SETUP: js.lib.Symbol;

    /**
     * Name of field.  Unique within each block.
     * Static labels are usually unnamed.
     */
    var name: Null<String>;

    /** Maximum characters of text to display before adding an ellipsis. */
    var maxDisplayLength: Int;

    /**
     * Editable fields usually show some sort of UI indicating they are
     * editable. They will also be saved by the serializer.
     */
    var EDITABLE: Bool;

    /**
     * Serializable fields are saved by the serializer, non-serializable fields
     * are not. Editable fields should also be serializable. This is not the
     * case by default so that SERIALIZABLE is backwards compatible.
     */
    var SERIALIZABLE: Bool;

    /**
     * Attach this field to a block.
     *
     * @param block The block containing this field.
     */
    function setSourceBlock(block: Block): Void;

    /**
     * Get the renderer constant provider.
     *
     * @returns The renderer constant provider.
     */
    // function getConstants(): Null<ConstantProvider>;

    /**
     * Get the block this field is attached to.
     *
     * @returns The block containing this field.
     * @throws An error if the source block is not defined.
     */
    function getSourceBlock(): Null<Block>;

    /**
     * Gets an ARIA-friendly label representation of this field's type.
     *
     * Implementations are responsible for, and encouraged to, return a localized
     * version of the ARIA representation of the field's type.
     *
     * @returns An ARIA representation of the field's type or null if it is
     *     unspecified.
     */
    function getAriaTypeName(): Null<String>;

    /**
     * Gets an ARIA-friendly label representation of this field's value.
     *
     * Note that implementations should generally always override this value to
     * ensure a non-null value is returned. The default implementation relies on
     * 'getText' which may return an empty String. A null return value from this
     * function will prompt ARIA label generation to skip the field's value
     * entirely when there may be a better contextual placeholder to use isstead.
     *
     * For example, to aVoid hiding an empty text input field from screen reader,
     * implementations should ensure that if the text is an empty String, this
     * function would return an appropriate, localized value such as "empty text".
     *
     * Implementations are responsible for, and encouraged to, return a localized
     * version of the ARIA representation of the field's value.
     *
     * @returns An ARIA representation of the field's text, or null if no text is
     *     currently defined or known for the field.
     */
    function getAriaValue(): Null<String>;

    /**
     * Computes a descriptive ARIA label to represent this field with configurable
     * verbosity.
     *
     * A 'verbose' label includes type information, if available, whereas a
     * non-verbose label only contains the field's value.
     *
     * Note that this will always return the latest representation of the field's
     * label which may differ from any previously set ARIA label for the field
     * itself. Implementations are largely responsible for ensuring that the
     * field's ARIA label is set correctly at relevant moments in the field's
     * lifecycle (such as when its value changes).
     *
     * Finally, it is never guaranteed that implementations use the label returned
     * by this method for their actual ARIA label. Some implementations may rely
     * on other contexts to convey information like the field's value. Example:
     * checkboxes represent their checked/non-checked status (i.e. value) through
     * a separate ARIA property.
     *
     * If the field's value is empty then it will return a localized placeholder
     * indicating that its value is empty. If this method returns an empty String,
     * the output will be ignored when composing the block-level ARIA label. Make
     * sure you want your label hidden from screenreaders before returning an
     * empty String.
     *
     * @param includeTypeInfo Whether to include the field's type information in
     *     the returned label, if available.
     */
    function computeAriaLabel(?includeTypeInfo: Bool): String;

    /**
     * Initializes the model of the field after it has been installed on a block.
     * No-op by default.
     */
    function initModel(): Void;

    /**
     * Defines whether this field should take up the full block or not.
     *
     * This is typically only done for certain kinds of fields and in certain
     * renderers. You should only override this if you're sure your field will
     * render correctly in zelos and other renderers that support full-block
     * fields.
     *
     * Blocks that contain only a single field that is a full-block-field
     * have a special appearance in some renderers and their behavior is
     * unique, because we pretend that the field is a whole block in some cases.
     * This is hacky and you should use caution when attempting to do anything
     * with this method.
     */
    function isFullBlockField(): Bool;

    /**
     * Returns whether this field is a static text label (ex. FieldLabel).
     * Used internally instead of `instanceof FieldLabel` to aVoid circular imports.
     *
     * @internal
     */
    function isLabelField(): Bool;

    /**
     * Sets the field's value based on the given XML element. Should only be
     * called by Blockly.Xml.
     *
     * @param fieldElement The element containing info about the field's state.
     */
    function fromXml(fieldElement: Element): Void;
    
    /**
     * Serializes this field's value to XML. Should only be called by Blockly.Xml.
     *
     * @param fieldElement The element to populate with info about the field's
     *     state.
     * @returns The element containing info about the field's state.
     */
    function toXml(fieldElement: Element): Element;

    /**
     * Saves this fields value as something which can be serialized to JSON.
     * Should only be called by the serialization system.
     *
     * @param _doFullSerialization If true, this signals to the field that if it
     *     normally just saves a reference to some state (eg variable fields) it
     *     should instead serialize the full state of the thing being referenced.
     *     See the
     *     {@link https://developers.devsite.google.com/blockly/guides/create-custom-blocks/fields/customizing-fields/creating#full_serialization_and_backing_data | field serialization docs}
     *     for more information.
     * @returns JSON serializable state.
     */
    function saveState(?_doFullSerialization: Bool): Any;

    /**
     * Sets the field's state based on the given state value. Should only be
     * called by the serialization system.
     *
     * @param state The state we want to apply to the field.
     */
    function loadState(state: Any): Void;

    /**
     * Loads the given state using either the old XML hooks, if they should be
     * used. Returns true to indicate loading has been handled, false otherwise.
     *
     * @param callingClass The class calling this method.
     *     Used to see if `this` has overridden any relevant hooks.
     * @param state The state to apply to the field.
     * @returns Whether the state was applied or not.
     */
    function loadLegacyState(callingClass: FieldProto, state: Any): Bool;

    /**
     * Dispose of all DOM objects and events belonging to this editable field.
     */
    function dispose(): Void;

    /** Add or remove the UI indicating if this field is editable or not. */
    function updateEditable(): Void;

    /**
     * Set whether this field's value can be changed using the editor when the
     *     source block is editable.
     *
     * @param enabled True if enabled.
     */
    function setEnabled(enabled: Bool): Void;

    /**
     * Check whether this field's value can be changed using the editor when the
     *     source block is editable.
     *
     * @returns Whether this field is enabled.
     */
    function isEnabled(): Bool;

    /**
     * Check whether this field defines the showEditor_ function.
     *
     * @returns Whether this field is clickable.
     */
    function isClickable(): Bool;

    /**
     * Check whether the field should be clickable while the block is in a flyout.
     * The default is that fields are clickable in always-open flyouts such as the
     * simple toolbox, but not in autoclosing flyouts such as the category toolbox.
     * Subclasses may override this function to change this behavior. Note that
     * `isClickable` must also return true for this to have any effect.
     *
     * @param autoClosingFlyout true if the containing flyout is an auto-closing one.
     * @returns Whether the field should be clickable while the block is in a flyout.
     */
    function isClickableInFlyout(autoClosingFlyout: Bool): Bool;

    /**
     * Check whether this field is currently editable.  Some fields are never
     * EDITABLE (e.g. text labels). Other fields may be EDITABLE but may exist on
     * non-editable blocks or be currently disabled.
     *
     * @returns Whether this field is currently enabled, editable and on an
     *     editable block.
     */
    function isCurrentlyEditable(): Bool;

    /**
     * Check whether this field should be serialized by the XML renderer.
     * Handles the logic for backwards compatibility and incongruous states.
     *
     * @returns Whether this field should be serialized or not.
     */
    function isSerializable(): Bool;

    /**
     * Gets whether this editable field is visible or not.
     *
     * @returns True if visible.
     */
    function isVisible(): Bool;
    
    /**
     * Sets a new validation function for editable fields, or clears a previously
     * set validator.
     *
     * The validator function takes in the new field value, and returns
     * validated value. The validated value could be the input value, a modified
     * version of the input value, or null to abort the change.
     *
     * If the function does not return anything (or returns undefined) the new
     * value is accepted as valid. This is to allow for fields using the
     * validated function as a field-level change event notification.
     *
     * @param handler The validator function or null to clear a previous
     *     validator.
     */
    function setValidator(handler: FieldValidator<T>): Void;

    /**
     * Gets the validation function for editable fields, or null if not set.
     *
     * @returns Validation function, or null.
     */
    function getValidator(): Null<FieldValidator<T>>;

    /**
     * Gets the group element for this editable field.
     * Used for measuring the size and for positioning.
     *
     * @returns The group element.
     */
    function getSvgRoot(): Null<SVGElement>;

    /**
     * Updates the field to match the colour/style of the block.
     *
     * Non-abstract sub-classes may wish to implement this if the colour of the
     * field depends on the colour of the block. It will automatically be called
     * at relevant times, such as when the parent block or renderer changes.
     *
     * See {@link
     * https://developers.google.com/blockly/guides/create-custom-blocks/fields/customizing-fields/creating#matching_block_colours
     * | the field documentation} for more information, or FieldDropdown for an
     * example.
     */
    function applyColour(): Void;

    /**
     * Calls showEditor_ when the field is clicked if the field is clickable.
     * Do not override.
     *
     * @param e Optional mouse event that triggered the field to open, or
     *     undefined if triggered programmatically.
     * @sealed
     * @internal
     */
    function showEditor(?e: Event): Void;
    
    /**
     * A developer hook to reposition the WidgetDiv during a window resize. You
     * need to define this hook if your field has a WidgetDiv that needs to
     * reposition itself when the window is resized. For example, text input
     * fields define this hook so that the input WidgetDiv can reposition itself
     * on a window resize event. This is especially important when modal inputs
     * have been disabled, as Android devices will fire a window resize event when
     * the soft keyboard opens.
     *
     * If you want the WidgetDiv to hide itself instead of repositioning, return
     * false. This is the default behavior.
     *
     * DropdownDivs already handle their own positioning logic, so you do not need
     * to override this function if your field only has a DropdownDiv.
     *
     * @returns True if the field should be repositioned,
     *    false if the WidgetDiv should hide itself instead.
     */
    function repositionForWindowResize(): Bool;

    /**
     * Returns the height and width of the field.
     *
     * This should *in general* be the only place render_ gets called from.
     *
     * @returns Height and width.
     */
    function getSize(): Size;

    /**
     * Notifies the field that it has changed locations.
     *
     * @param _coord The location of this field's block's top-start corner
     *     in workspace coordinates.
     */
    function onLocationChange(_coord: Coordinate): Void;

    /**
     * Get the text from this field.
     * Override getText_ to provide a different behavior than simply casting the
     * value to a String.
     *
     * @returns Current text.
     * @sealed
     */
    function getText(): String;

    /**
     * Force a rerender of the block that this field is installed on, which will
     * rerender this field and adjust for any sizing changes.
     * Other fields on the same block will not rerender, because their sizes have
     * already been recorded.
     */
    function forceRerender(): Void;

    /**
     * Used to change the value of the field. Handles validation and events.
     * Subclasses should override doClassValidation_ and doValueUpdate_ rather
     * than this method.
     *
     * @param newValue New value.
     * @param fireChangeEvent Whether to fire a change event. Defaults to true.
     *     Should usually be true unless the change will be reported some other
     *     way, e.g. an intermediate field change event.
     * @sealed
     */
    function setValue(newValue: Any, ?fireChangeEvent: Bool): Void;

    /**
     * Get the current value of the field.
     *
     * @returns Current value.
     */
    function getValue(): Null<T>;

    /**
     * Sets the tooltip for this field.
     *
     * @param newTip The text for the tooltip, a function that returns the text
     *     for the tooltip, a parent object whose tooltip will be used, or null to
     *     display the tooltip of the parent block. To not display a tooltip pass
     *     the empty String.
     */
    function setTooltip(newTip: Null<Tooltip.TipInfo>): Void;

    /**
     * Returns the tooltip text for this field.
     *
     * @returns The tooltip text for this field.
     */
    function getTooltip(): String;

    /**
     * Whether this field references any Blockly variables.  If true it may need
     * to be handled differently during serialization and deserialization.
     * Subclasses may override this.
     *
     * @returns True if this field has any variable references.
     */
    function referencesVariables(): Bool;

    /**
     * Refresh the variable name referenced by this field if this field references
     * variables.
     */
    function refreshVariableName(): Void;

    /**
     * Search through the list of inputs and their fields in order to find the
     * parent input of a field.
     *
     * @returns The input that the field belongs to.
     * @internal
     */
    function getParentInput(): Input;

    /**
     * Returns whether or not we should flip the field in RTL.
     *
     * @returns True if we should flip in RTL.
     */
    function getFlipRtl(): Bool;
    
    /**
     * Handles the given keyboard shortcut.
     *
     * @param _shortcut The shortcut to be handled.
     * @returns True if the shortcut has been handled, false otherwise.
     */
    // function onShortcut(_shortcut: KeyboardShortcut): Bool;

    // /** See IFocusableNode.getFocusableElement. */
    // getFocusableElement(): HTMLElement | SVGElement;
    // /** See IFocusableNode.getFocusableTree. */
    // getFocusableTree(): IFocusableTree;
    // /** See IFocusableNode.onNodeFocus. */
    // onNodeFocus(): Void;
    // /** See IFocusableNode.onNodeBlur. */
    // onNodeBlur(): Void;
    // /** See IFocusableNode.canBeFocused. */
    // canBeFocused(): Bool;
    /**
     * Handles the user acting on this field via keyboard navigation.
     * Shows and focuses the field editor.
     */
    function performAction(): Void;

    /**
     * Recomputes the aria state and label for this field. Fields are generally hidden
     * when in blocks in the flyout (except for top-level full-block fields), and
     * otherwise set to a role of button (indicating they can be clicked to edit)
     * and given the label returned from their `computeAriaLabel` method.
     *
     * Subclasses can override this in order to change the role or label, but they must
     * ensure they keep the correct behavior for fields in flyout blocks.
     *
     * This method will return a Bool indicating if the element is displayed in the
     * aria tree or not. This can be used by subclasses to determine whether or not
     * to continue customizing the role and label (hidden elements should not have labels).
     *
     * @returns true if the element is in the accessibility tree, false if the aria state is hidden
     */
    function recomputeAriaContext(): Bool;

    /**
     * Subclasses should reimplement this method to construct their Field
     * subclass from a JSON arg object.
     *
     * It is an error to attempt to register a field subclass in the
     * FieldRegistry if that subclass has not overridden this method.
     *
     * @param _options JSON configuration object with properties needed
     *    to configure a specific field.
     */
    static function fromJson(_options: FieldConfig): Field<Any>;
}
