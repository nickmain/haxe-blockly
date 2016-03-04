package blockly;


@:native("Blockly.Mutator")
extern class Mutator {

    /**
     * Class for a mutator dialog.
     * @param quarkNames List of names of sub-blocks for flyout.
     */
    public function new(quarkNames: Array<String>);

    /**
     * Show or hide the mutator bubble.
     */
    public function setVisible(visible: Bool): Void;
}
