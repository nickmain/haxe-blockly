package backend.flask;

import haxe.Constraints.Function;
import python.KwArgs;

@:pythonImport("flask", "Flask")
extern class Flask {
    function new(module:String);
    function run():Void;

    @:overload(function<T:Function>(path:String):T->T {})
    @:overload(function<T:Function>(path:String, kwargs: KwArgs<{methods:Array<String>}>):T->T {})
    function route<T:Function>(path:String):T->T;

    var debug: Bool;
}

