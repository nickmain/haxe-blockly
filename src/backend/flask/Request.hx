package backend.flask;

@:pythonImport("flask", "request")
extern class Request {
    static var method: String;
}