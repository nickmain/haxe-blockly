package backend.flask;

import haxe.Constraints.Function;

@:pythonImport("flask", "Flask")
extern class Flask {
    function new(module:String);
    function run():Void;
    function route<T:Function>(path:String):T->T;
    var debug: Bool;
}

