// through2 is a thin wrapper around node transform streams
var through = require('through2');
var gutil = require('gulp-util');
var PluginError = gutil.PluginError;

// Consts
const PLUGIN_NAME = 'gulp-nano';

function nanoStream(content) {
    var stream = through();
    stream.write(content);
    return stream;
}

// Plugin level function(dealing with files)
function gulpNano(filler) {
    var nano = function (template, data, context) {
	//можно ввести простанство имен или контекст, типа {{build:path.to.var}}
	//TODO спецсимволы в контексте
	var regex = new RegExp("\\{\\{" + context + ":([\\w\\.]*)\\}\\}", "g");
        //return template.replace(/\{\{([\w\.]*)\}\}/g, function(str, key) {
        return template.replace(regex, function(str, key) {
            var keys = key.split("."), v = data[keys.shift()];
            for (var i = 0, l = keys.length; i < l; i++) v = v[keys[i]];
            if(typeof v !== "undefined" && v !== null) return v;
	    else throw new Error("gulp-nano: key " + key + "not found in filling data");
	    /*
	    var def = "{{" + key + "}}"; //TODO с контекстом def не нужен - если что то пошло не так - бросаем эксепшн
            var keys = key.split(".");
	    if(keys.length) var v = data[keys.shift()];
	    else return def;
	    if(!v) return def;
            for (var i = 0, l = keys.length; i < l; i++) v = keys[i] in v ? v[keys[i]] : null;
            return (typeof v !== "undefined" && v !== null) ? v : def;
	   */
        });
    }
    if (!filler) {
        throw new PluginError(PLUGIN_NAME, 'Missing filler!');
    }
    if ("object" !== typeof filler) {
        throw new PluginError(PLUGIN_NAME, 'Wrong type of filler!');
    }
    //тут вообще то и массив пройдет, хотя массив нам не нужен
    //prefixText = new Buffer(prefixText); // allocate ahead of time

// Creating a stream through which each file will pass
    return through.obj(function(file, enc, cb) {
	    //console.log("INPUT: ", file);
        if (file.isNull()) {
            // return empty file
            return cb(null, file);
        }
        if (file.isBuffer()) {
            file.contents = new Buffer(nano(file.contents.toString(enc), filler, "build"), enc);
        }
        if (file.isStream()) {
            file.contents = nanoStream(nano(file.contents.read() , filler, "build"));
        }
            //console.log("OUTPUT: ", file);
        cb(null, file);

    });
}
// Exporting the plugin main function
module.exports = gulpNano;
