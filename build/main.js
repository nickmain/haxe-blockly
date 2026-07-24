// Toolbox definition with a few example block categories.
const toolbox = {
  kind: 'categoryToolbox',
  contents: [
    {
      kind: 'category',
      name: 'Logic',
      colour: '210',
      contents: [
        { kind: 'block', type: 'controls_if' },
        { kind: 'block', type: 'logic_compare' },
        { kind: 'block', type: 'logic_operation' },
        { kind: 'block', type: 'logic_boolean' },
      ],
    },
    {
      kind: 'category',
      name: 'Loops',
      colour: '120',
      contents: [
        {
          kind: 'block',
          type: 'controls_repeat_ext',
          inputs: {
            TIMES: {
              shadow: { type: 'math_number', fields: { NUM: 10 } },
            },
          },
        },
        { kind: 'block', type: 'controls_whileUntil' },
      ],
    },
    {
      kind: 'category',
      name: 'Math',
      colour: '230',
      contents: [
        { kind: 'block', type: 'math_number', fields: { NUM: 123 } },
        {
          kind: 'block',
          type: 'math_arithmetic',
          inputs: {
            A: { shadow: { type: 'math_number', fields: { NUM: 1 } } },
            B: { shadow: { type: 'math_number', fields: { NUM: 1 } } },
          },
        },
      ],
    },
    {
      kind: 'category',
      name: 'Text',
      colour: '160',
      contents: [
        {
          kind: 'block',
          type: 'text',
          fields: { TEXT: '' },
        },
        {
          kind: 'block',
          type: 'text_print',
          inputs: {
            TEXT: {
              shadow: { type: 'text', fields: { TEXT: 'abc' } },
            },
          },
        },
      ],
    },
  ],
};

// Inject Blockly into the page, filling the #blocklyDiv element.
const workspace = Blockly.inject('blocklyDiv', {
  toolbox,
  // Standard zoom controls (the +/-/reset buttons) and mouse-wheel zoom.
  zoom: {
    controls: true,
    wheel: true,
    startScale: 1.0,
    maxScale: 3,
    minScale: 0.3,
    scaleSpeed: 1.2,
    pinch: true,
  },
});

// Seed the workspace with a print block holding a "Hello World" text block so
// it is present on every load/refresh.
Blockly.serialization.workspaces.load(
  {
    blocks: {
      languageVersion: 0,
      blocks: [
        {
          type: 'text_print',
          x: 50,
          y: 50,
          inputs: {
            TEXT: {
              block: {
                type: 'text',
                fields: { TEXT: 'Hello World' },
              },
            },
          },
        },
      ],
    },
  },
  workspace,
);

// Keep the workspace sized to the window.
function resizeWorkspace() {
  Blockly.svgResize(workspace);
}

window.addEventListener('resize', resizeWorkspace);
resizeWorkspace();
