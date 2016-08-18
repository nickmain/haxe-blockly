// Generated by Haxe 3.3.0
(function () { "use strict";
function $extend(from, fields) {
	function Inherit() {} Inherit.prototype = from; var proto = new Inherit();
	for (var name in fields) proto[name] = fields[name];
	if( fields.toString !== Object.prototype.toString ) proto.toString = fields.toString;
	return proto;
}
Math.__name__ = ["Math"];
var Std = function() { };
Std.__name__ = ["Std"];
Std.string = function(s) {
	return js_Boot.__string_rec(s,"");
};
var Type = function() { };
Type.__name__ = ["Type"];
Type.getClassName = function(c) {
	var a = c.__name__;
	if(a == null) {
		return null;
	}
	return a.join(".");
};
var app_Main = function() {
	this.application = new blockly_BlocklyApp();
	this.application.showStartBlockHats(true);
	this.application.registerBlock(app_blocks_FooBarBlock);
	this.application.registerBlock(app_blocks_DemoQuestions);
	this.application.registerBlock(app_blocks_KitchenSink);
	this.application.inject("blocklyArea",new blockly_BlocklyConfig().setMediaPath("media/").useToolboxId("toolbox").setGrid(new blockly_Grid()).setZoom(new blockly_Zoom()).showTrashcan(true));
	this.application.addSelectionChangeListener(function() {
		console.log("Selection Changed");
	});
	this.resultArea = window.document.getElementById("resultArea");
	this.application.loadWorkspaceFromLocalStorage("demo");
	Blockly.getMainWorkspace().addChangeListener($bind(this,this.workspaceChanged));
};
app_Main.__name__ = ["app","Main"];
app_Main.main = function() {
	app_Main.mainApp = new app_Main();
};
app_Main.prototype = {
	workspaceChanged: function() {
		console.log("workspaceChanged");
		this.application.workspaceToLocalStorage("demo");
		this.resultArea.innerText = this.application.workspaceToPrettyXML();
	}
};
var blockly_CustomBlock = function(block,application) {
	this.block = block;
	this.application = application;
};
blockly_CustomBlock.__name__ = ["blockly","CustomBlock"];
blockly_CustomBlock.fromBlock = function(block) {
	return block.haxeBlock;
};
blockly_CustomBlock.prototype = {
	validate: function() {
	}
	,domToMutation: function(xmlElement) {
	}
	,mutationToDom: function() {
		return null;
	}
	,decompose: function(workspace) {
		return null;
	}
	,compose: function(containerBlock) {
	}
	,onChange: function(event) {
	}
	,getPreviousBlock: function() {
		if(this.block.previousConnection == null) {
			return null;
		}
		return this.block.previousConnection.targetBlock();
	}
	,getOutputBlock: function() {
		if(this.block.outputConnection == null) {
			return null;
		}
		return this.block.outputConnection.targetBlock();
	}
	,appendLabelledField: function(label,field,fieldName) {
		return this.block.appendDummyInput().appendField(label).appendField(field,fieldName);
	}
	,appendField: function(field,fieldName) {
		return this.block.appendDummyInput().appendField(field,fieldName);
	}
};
var app_blocks_DemoQuestions = function(block,application) {
	blockly_CustomBlock.call(this,block,application);
	block.setColour("#ff0000");
	block.setOutput(true);
	block.setTooltip("Some possible choices");
	this.appendLabelledField("You can choose this",new Blockly.FieldCheckbox(blockly__$FieldCheckbox_FieldCheckboxValue_$Impl_$.fromBool(false),null),"check1").setAlign(Blockly.ALIGN_RIGHT);
	this.appendLabelledField("You can also choose this",new Blockly.FieldCheckbox(blockly__$FieldCheckbox_FieldCheckboxValue_$Impl_$.fromBool(true),null),"check2").setAlign(Blockly.ALIGN_RIGHT);
	this.appendLabelledField("This is another option",new Blockly.FieldCheckbox(blockly__$FieldCheckbox_FieldCheckboxValue_$Impl_$.fromBool(false),null),"check3").setAlign(Blockly.ALIGN_RIGHT);
	this.appendLabelledField("Or you can choose this one",new Blockly.FieldCheckbox(blockly__$FieldCheckbox_FieldCheckboxValue_$Impl_$.fromBool(false),null),"check4").setAlign(Blockly.ALIGN_RIGHT);
};
app_blocks_DemoQuestions.__name__ = ["app","blocks","DemoQuestions"];
app_blocks_DemoQuestions.__super__ = blockly_CustomBlock;
app_blocks_DemoQuestions.prototype = $extend(blockly_CustomBlock.prototype,{
});
var app_blocks_FooBarBlock = function(block,application) {
	this.count = 1;
	var _gthis = this;
	blockly_CustomBlock.call(this,block,application);
	console.log("hello world");
	this.count = 1;
	block.setColour("#cc88ff");
	block.setPreviousStatement(false);
	block.setNextStatement(true);
	block.setTooltip(function() {
		return "Hello World !\nThis is going to be interesting\n" + _gthis.count++;
	});
	block.appendDummyInput().appendField(new Blockly.FieldCheckbox("FALSE"),"check").appendField("Hello World");
	block.appendStatementInput("stat1");
	block.appendValueInput("inp1").appendField(new Blockly.FieldLabel("Hello World","svgDarkText"),null);
};
app_blocks_FooBarBlock.__name__ = ["app","blocks","FooBarBlock"];
app_blocks_FooBarBlock.__super__ = blockly_CustomBlock;
app_blocks_FooBarBlock.prototype = $extend(blockly_CustomBlock.prototype,{
});
var app_blocks_KitchenSink = function(block,application) {
	this.hasOut = true;
	this.hasPrev = true;
	blockly_CustomBlock.call(this,block,application);
	block.setColour("#226622");
	block.setNextStatement(true);
	block.setTooltip("All field types");
	block.setHelpUrl("http://blog.nickmain.com");
	block.setCommentText("Everything but the kitchen sink.");
	block.setWarningText("There are things yet to do.");
	block.setMutator(new Blockly.Mutator(["controls_if_elseif","controls_if_else"]));
	block.appendDummyInput();
	this.appendField(new Blockly.FieldImage("haxe.png",100,25),"img1").setAlign(Blockly.ALIGN_CENTRE);
	this.appendLabelledField("Checkbox",new Blockly.FieldCheckbox(blockly__$FieldCheckbox_FieldCheckboxValue_$Impl_$.fromBool(false),$bind(this,this.checkboxChanged)),"check1").setAlign(Blockly.ALIGN_RIGHT);
	this.appendLabelledField("Text Field",new Blockly.FieldTextInput("hello"),"text1").setAlign(Blockly.ALIGN_RIGHT);
	this.appendLabelledField("Number Field",new Blockly.FieldTextInput("1.0",Blockly.FieldTextInput.numberValidator),"text2").setAlign(Blockly.ALIGN_RIGHT);
	this.appendLabelledField("Int >0 Field",new Blockly.FieldTextInput("1",Blockly.FieldTextInput.nonnegativeIntegerValidator),"text3").setAlign(Blockly.ALIGN_RIGHT);
	this.appendLabelledField("Angle Field",new Blockly.FieldAngle("45",Blockly.FieldAngle.angleValidator),"angle1");
	this.appendLabelledField("Colors",new Blockly.FieldColour("#ff0000"),"color1").setAlign(Blockly.ALIGN_RIGHT);
	this.appendLabelledField("Custom Colors",new Blockly.FieldColour("#ffffe0").setColours(["#ffffe0","#ffff00","#ffd700","#eedd82","#daa520","#b8860b"]).setColumns(3),"color2").setAlign(Blockly.ALIGN_RIGHT);
	this.appendLabelledField("Drop Down Menu",new Blockly.FieldDropdown([["foo","FOO"],["bar","BAR"],["bat","BAT"]]),"menu1").setAlign(Blockly.ALIGN_RIGHT);
	this.appendLabelledField("Variable",new Blockly.FieldVariable("foo"),"var1").setAlign(Blockly.ALIGN_RIGHT);
	var checkbox = new Blockly.FieldCheckbox(blockly__$FieldCheckbox_FieldCheckboxValue_$Impl_$.fromBool(false));
	var input1 = block.appendValueInput("input1").appendField(checkbox,"checkX").setAlign(Blockly.ALIGN_RIGHT);
	checkbox.setValidator(function(checked) {
		if(checked && input1.connection.targetConnection == null) {
			var textBlock = block.workspace.newBlock("text");
			input1.connection.connect(textBlock.outputConnection);
			textBlock.setFieldValue("Hello World","TEXT");
			textBlock.initSvg();
			textBlock.render(true);
		} else if(input1.connection.targetBlock() != null) {
			input1.connection.targetBlock().setWarningText("Unplugged - discard whenever");
			input1.connection.targetBlock().warning.setVisible(true);
			input1.connection.targetBlock().setDisabled(true);
			input1.connection.targetBlock().unplug(true,true);
		}
		return checked;
	});
};
app_blocks_KitchenSink.__name__ = ["app","blocks","KitchenSink"];
app_blocks_KitchenSink.__super__ = blockly_CustomBlock;
app_blocks_KitchenSink.prototype = $extend(blockly_CustomBlock.prototype,{
	checkboxChanged: function(state) {
		var req = new XMLHttpRequest();
		req.overrideMimeType("text/xml");
		req.open("POST","http://127.0.0.1:5000/save",true);
		req.send(this.application.workspaceToPrettyXML());
		return state;
	}
	,onChange: function(event) {
		if(this.getPreviousBlock() != null) {
			this.block.setOutput(false);
			this.hasOut = false;
			this.hasPrev = true;
		} else if(this.getOutputBlock() != null) {
			this.block.setPreviousStatement(false);
			this.hasOut = true;
			this.hasPrev = false;
		} else {
			this.block.setPreviousStatement(true);
			this.block.setOutput(true);
			this.hasOut = true;
			this.hasPrev = true;
		}
	}
	,domToMutation: function(e) {
		this.hasPrev = e.getAttribute("has_prev") == "true";
		this.hasOut = e.getAttribute("has_out") == "true";
		if(this.hasPrev) {
			this.block.setPreviousStatement(true);
		}
		if(this.hasOut) {
			this.block.setOutput(true);
		}
	}
	,mutationToDom: function() {
		var container = window.document.createElement("mutation");
		container.setAttribute("has_prev","" + Std.string(this.hasPrev));
		container.setAttribute("has_out","" + Std.string(this.hasOut));
		return container;
	}
	,decompose: function(workspace) {
		var containerBlock = workspace.newBlock("app.blocks.FooBarBlock");
		containerBlock.initSvg();
		return containerBlock;
	}
});
var blockly_BlocklyApp = function() {
};
blockly_BlocklyApp.__name__ = ["blockly","BlocklyApp"];
blockly_BlocklyApp.prototype = {
	inject: function(divId,config) {
		this.divId = divId;
		this.workspace = Blockly.inject(divId,config);
	}
	,addSelectionChangeListener: function(callback) {
		var blocklyDiv = window.document.getElementById(this.divId);
		if(blocklyDiv != null) {
			blocklyDiv.addEventListener("blocklySelectChange",function(e) {
				callback();
			},false);
		}
	}
	,showStartBlockHats: function(showHat) {
		Blockly.BlockSvg.START_HAT = showHat;
	}
	,workspaceToPrettyXML: function() {
		return Blockly.Xml.domToPrettyText(Blockly.Xml.workspaceToDom(this.workspace));
	}
	,workspaceToLocalStorage: function(key) {
		var xml = Blockly.Xml.domToText(Blockly.Xml.workspaceToDom(this.workspace));
		window.localStorage.setItem(key,xml);
		return xml;
	}
	,loadWorkspaceFromLocalStorage: function(key) {
		var xml = window.localStorage.getItem(key);
		if(xml == null) {
			return false;
		}
		Blockly.Xml.domToWorkspace(this.workspace,Blockly.Xml.textToDom(xml));
		return true;
	}
	,registerBlock: function(clazz) {
		var blocklyApp = this;
		Blockly.Blocks[Type.getClassName(clazz)] = { init : function() {
			this.haxeBlock = new clazz(this,blocklyApp);
		}, validate : function() {
			var haxeBlock = this.haxeBlock;
			haxeBlock.validate();
		}, domToMutation : function(xmlElement) {
			var haxeBlock1 = this.haxeBlock;
			haxeBlock1.domToMutation(xmlElement);
		}, mutationToDom : function() {
			var haxeBlock2 = this.haxeBlock;
			return haxeBlock2.mutationToDom();
		}, decompose : function(workspace) {
			var haxeBlock3 = this.haxeBlock;
			return haxeBlock3.decompose(workspace);
		}, compose : function(containerBlock) {
			var haxeBlock4 = this.haxeBlock;
			haxeBlock4.compose(containerBlock);
		}, onchange : function(event) {
			var haxeBlock5 = this.haxeBlock;
			haxeBlock5.onChange(event);
		}};
	}
};
var blockly_Grid = function() {
	this.snap = true;
	this.colour = "#ccc";
	this.length = 3;
	this.spacing = 20;
};
blockly_Grid.__name__ = ["blockly","Grid"];
var blockly_Zoom = function() {
	this.scaleSpeed = 1.2;
	this.minScale = 0.3;
	this.maxScale = 3;
	this.startScale = 1.0;
	this.wheel = true;
	this.controls = true;
};
blockly_Zoom.__name__ = ["blockly","Zoom"];
var blockly_BlocklyConfig = function() {
};
blockly_BlocklyConfig.__name__ = ["blockly","BlocklyConfig"];
blockly_BlocklyConfig.prototype = {
	setMediaPath: function(path) {
		this.media = path;
		return this;
	}
	,setGrid: function(grid) {
		this.grid = grid;
		return this;
	}
	,showTrashcan: function(show) {
		this.trashcan = show;
		return this;
	}
	,setZoom: function(zoom) {
		this.zoom = zoom;
		return this;
	}
	,useToolboxId: function(id) {
		this.toolbox = window.document.getElementById(id);
		return this;
	}
};
var blockly__$FieldCheckbox_FieldCheckboxValue_$Impl_$ = {};
blockly__$FieldCheckbox_FieldCheckboxValue_$Impl_$.__name__ = ["blockly","_FieldCheckbox","FieldCheckboxValue_Impl_"];
blockly__$FieldCheckbox_FieldCheckboxValue_$Impl_$.fromBool = function(b) {
	if(b) {
		return "TRUE";
	} else {
		return "FALSE";
	}
};
var js_Boot = function() { };
js_Boot.__name__ = ["js","Boot"];
js_Boot.__string_rec = function(o,s) {
	if(o == null) {
		return "null";
	}
	if(s.length >= 5) {
		return "<...>";
	}
	var t = typeof(o);
	if(t == "function" && (o.__name__ || o.__ename__)) {
		t = "object";
	}
	switch(t) {
	case "function":
		return "<function>";
	case "object":
		if(o instanceof Array) {
			if(o.__enum__) {
				if(o.length == 2) {
					return o[0];
				}
				var str = o[0] + "(";
				s += "\t";
				var _g1 = 2;
				var _g = o.length;
				while(_g1 < _g) {
					var i = _g1++;
					if(i != 2) {
						str += "," + js_Boot.__string_rec(o[i],s);
					} else {
						str += js_Boot.__string_rec(o[i],s);
					}
				}
				return str + ")";
			}
			var l = o.length;
			var i1;
			var str1 = "[";
			s += "\t";
			var _g11 = 0;
			var _g2 = l;
			while(_g11 < _g2) {
				var i2 = _g11++;
				str1 += (i2 > 0?",":"") + js_Boot.__string_rec(o[i2],s);
			}
			str1 += "]";
			return str1;
		}
		var tostr;
		try {
			tostr = o.toString;
		} catch( e ) {
			return "???";
		}
		if(tostr != null && tostr != Object.toString && typeof(tostr) == "function") {
			var s2 = o.toString();
			if(s2 != "[object Object]") {
				return s2;
			}
		}
		var k = null;
		var str2 = "{\n";
		s += "\t";
		var hasp = o.hasOwnProperty != null;
		for( var k in o ) {
		if(hasp && !o.hasOwnProperty(k)) {
			continue;
		}
		if(k == "prototype" || k == "__class__" || k == "__super__" || k == "__interfaces__" || k == "__properties__") {
			continue;
		}
		if(str2.length != 2) {
			str2 += ", \n";
		}
		str2 += s + k + " : " + js_Boot.__string_rec(o[k],s);
		}
		s = s.substring(1);
		str2 += "\n" + s + "}";
		return str2;
	case "string":
		return o;
	default:
		return String(o);
	}
};
var $_, $fid = 0;
function $bind(o,m) { if( m == null ) return null; if( m.__id__ == null ) m.__id__ = $fid++; var f; if( o.hx__closures__ == null ) o.hx__closures__ = {}; else f = o.hx__closures__[m.__id__]; if( f == null ) { f = function(){ return f.method.apply(f.scope, arguments); }; f.scope = o; f.method = m; o.hx__closures__[m.__id__] = f; } return f; }
String.__name__ = ["String"];
Array.__name__ = ["Array"];
app_Main.main();
})();
