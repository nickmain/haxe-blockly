package blockly;

import haxe.extern.EitherType;
import js.html.DOMPoint;

/**
 * Class for representing coordinates and positions.
 */
extern class Coordinate {
    var x: Float;
    var y: Float;

    /**
     * @param x Left.
     * @param y Top.
     */
    function new(x: Float, y: Float);

    /**
     * Creates a new copy of this coordinate.
     *
     * @returns A copy of this coordinate.
     */
    function clone(): Coordinate;

    /**
     * Scales this coordinate by the given scale factor.
     *
     * @param s The scale factor to use for both x and y dimensions.
     * @returns This coordinate after scaling.
     */
    function scale(s: Float): Coordinate;

    /**
     * Translates this coordinate by the given offsets.
     * respectively.
     *
     * @param tx The value to translate x by.
     * @param ty The value to translate y by.
     * @returns This coordinate after translating.
     */
    function translate(tx: Float, ty: Float): Coordinate;

    /**
     * Compares coordinates for equality.
     *
     * @param a A Coordinate.
     * @param b A Coordinate.
     * @returns True iff the coordinates are equal, or if both are null.
     */
    static function equals(?a: Null<Coordinate>, ?b: Null<Coordinate>): Bool;

    /**
     * Returns the distance between two coordinates.
     *
     * @param a A Coordinate.
     * @param b A Coordinate.
     * @returns The distance between `a` and `b`.
     */
    static function distance(a: Coordinate, b: Coordinate): Float;

    /**
     * Returns the magnitude of a coordinate.
     *
     * @param a A Coordinate.
     * @returns The distance between the origin and `a`.
     */
    static function magnitude(a: Coordinate): Float;

    /**
     * Returns the difference between two coordinates as a new
     * Coordinate.
     *
     * @param a An x/y coordinate.
     * @param b An x/y coordinate.
     * @returns A Coordinate representing the difference between `a` and `b`.
     */
    static function difference(a: EitherType<Coordinate, DOMPoint>, b: EitherType<Coordinate, DOMPoint>): Coordinate;

    /**
     * Returns the sum of two coordinates as a new Coordinate.
     *
     * @param a An x/y coordinate.
     * @param b An x/y coordinate.
     * @returns A Coordinate representing the sum of the two coordinates.
     */
    static function sum(a: EitherType<Coordinate, DOMPoint>, b: EitherType<Coordinate, DOMPoint>): Coordinate;
}
