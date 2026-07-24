package blockly;

/**
 * Class for representing sizes consisting of a width and height.
 */
extern class Size {
    var width: Float;
    var height: Float;

    /**
     * @param width Width.
     * @param height Height.
     */
    function new(width: Float, height: Float);

    /**
     * Compares sizes for equality.
     *
     * @param a A Size.
     * @param b A Size.
     * @returns True iff the sizes have equal widths and equal heights, or if both
     *     are null.
     */
    static function equals(?a: Null<Size>, ?b: Null<Size>): Bool;

    /**
     * Returns a new size with the maximum width and height values out of both
     * sizes.
     */
    static function max(a: Size, b: Size): Size;

    /**
     * Returns a new size with the minimum width and height values out of both
     * sizes.
     */
    static function min(a: Size, b: Size): Size;
}
