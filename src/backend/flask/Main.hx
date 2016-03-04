package backend.flask;

class Main {
    static function main() {
        var app = new Flask(untyped __name__);
        app.route("/")(index);
        app.route("/hello/<name>")(hello);
        app.debug = true;
        app.run();
    }

    static function index() {
        return "Hello, world !!!";
    }

    static function hello(name: String) {
        var template = new haxe.Template("Hello, <b>::name::</b> --&gt; <i>::method::</i><hr /><pre>::file::</pre>");
        var file = python.lib.Builtins.open("main.js", "r");
        var lines = file.readlines();
        file.close();

        var buff = "";
        for( line in lines ) {
            buff += line + "\n";
        }

        return template.execute({name: name, method: Request.method, file: buff });
    }
}