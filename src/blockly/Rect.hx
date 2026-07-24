package blockly;

/**
 * Class for representing rectangular regions.
 */
extern class Rect {
    var top: Float;
    var bottom: Float;
    var left: Float;
    var right: Float;

    /**
     * @param top Top.
     * @param bottom Bottom.
     * @param left Left.
     * @param right Right.
     */
    function new(top: Float, bottom: Float, left: Float, right: Float);

    /**
     * Converts a DOM or SVG Rect to a Blockly Rect.
     *
     * @param rect The rectangle to convert.
     * @returns A representation of the same rectangle as a Blockly Rect.
     */
    static function from(rect: js.html.DOMRect): Rect;

    /**
     * Creates a new copy of this rectangle.
     *
     * @returns A copy of this Rect.
     */
    function clone(): Rect;

    /** Returns the height of this rectangle. */
    function getHeight(): Float;

    /** Returns the width of this rectangle. */
    function getWidth(): Float;

    /** Returns the top left coordinate of this rectangle. */
    function getOrigin(): Coordinate;

    /**
     * Tests whether this rectangle contains a x/y coordinate.
     *
     * @param x The x coordinate to test for containment.
     * @param y The y coordinate to test for containment.
     * @returns Whether this rectangle contains given coordinate.
     */
    function contains(x: Float, y: Float): Bool;

    /**
     * Tests whether this rectangle intersects the provided rectangle.
     * Assumes that the coordinate system increases going down and left.
     *
     * @param other The other rectangle to check for intersection with.
     * @returns Whether this rectangle intersects the provided rectangle.
     */
    function intersects(other: Rect): Bool;

    /**
     * Compares bounding rectangles for equality.
     *
     * @param a A Rect.
     * @param b A Rect.
     * @returns True iff the bounding rectangles are equal, or if both are null.
     */
    static function equals(?a: Null<Rect>, ?b: Null<Rect>): Bool;

    /**
     * Creates a new Rect using a position and supplied dimensions.
     *
     * @param position The upper left coordinate of the new rectangle.
     * @param width The width of the rectangle, in pixels.
     * @param height The height of the rectangle, in pixels.
     * @returns A newly created Rect using the provided Coordinate and dimensions.
     */
    static function createFromPoint(position: Coordinate, width: Float, height: Float): Rect;
}
