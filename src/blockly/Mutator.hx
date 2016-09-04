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

    /**
     * Dispose of this mutator
     */
    public function dispose(): Void;

    /**
     * Reconnect an block to a mutated input.
     * @param {Blockly.Connection} connectionChild Connection on child block.
     * @param {!Blockly.Block} block Parent block.
     * @param {string} inputName Name of input on parent block.
     * @return {boolean} True iff a reconnection was made, false otherwise.
     */
    public function reconnect(connectionChild: Connection, block: Block, inputName: String): Bool;
}
