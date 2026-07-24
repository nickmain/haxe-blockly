package blockly;

@:native("Blockly.FieldImage")
extern class FieldImage extends Field {

    /**
     * Class for an image.
     * @param {string} src The URL of the image.
     * @param {number} width Width of the image.
     * @param {number} height Height of the image.
     * @param {string=} opt_alt Optional alt text.
     */
    public function new(src: String, width: Int, height: Int, opt_alt: String = null);
}
