package utils;

// The structure returned by calling generator.next()
typedef JSGeneratorResult<T> = {
    var value(default, null):T;
    var done(default, null):Bool;
}

// The generator instance structure itself
typedef JSGenerator<T> = {
    function next(?value:Dynamic):JSGeneratorResult<T>;
    function return_(value:T):JSGeneratorResult<T>;
    function throw_(error:Dynamic):JSGeneratorResult<T>;
}

// abstract Generator<T>(JSGenerator<T>) from JSGenerator<T> {
//     private var cache:JSGeneratorResult<T>;

//     public inline function hasNext():Bool {
//         if (cache == null) cache = this.next();
//         return !cache.done;
//     }

//     public inline function next():T {
//         var result = (cache != null) ? cache : this.next();
//         cache = null; // Clear cache for next iteration
//         return result.value;
//     }
// }
