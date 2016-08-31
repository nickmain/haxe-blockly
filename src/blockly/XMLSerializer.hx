package blockly;

import js.html.Element;

@:native("Blockly.Xml")
extern class XMLSerializer {

    /**
     * Encode a block tree as XML.
     * @param workspace The workspace containing blocks.
     * @return XML document.
     */
    public static function workspaceToDom(workspace: Workspace): Element;

    /**
     * Converts a DOM structure into plain text.
     * @param dom A tree of XML elements.
     * @return text representation.
     */
    public static function domToText(dom: Element): String;

    /**
     * Converts a DOM structure into properly indented text.
     * @param dom A tree of XML elements.
     * @return text representation.
     */
    public static function domToPrettyText(dom: Element): String;

    /**
     * Converts plain text into a DOM structure.
     * Throws an error if XML doesn't parse.
     * @param text Text representation.
     * @return A tree of XML elements.
     */
    public static function textToDom(text: String): Element;

    /**
     * Decode an XML DOM and create blocks on the workspace.
     * @param workspace The workspace.
     * @param xml XML DOM.
     */
    public static function domToWorkspace(xml: Element, workspace: Workspace): Void;

    /**
     * Decode an XML block tag and create a block (and possibly sub blocks) on the
     * workspace.
     * @param workspace The workspace.
     * @param xmlBlock XML block element.
     * @return The root block created.
     */
    public static function domToBlock(xmlBlock: Element, workspace: Workspace): Block;

    /**
     * Remove any 'next' block (statements in a stack).
     * @param xmlBlock XML block element.
     */
    public function deleteNext(xmlBlock: Element): Void;
}
