
module.exports = {
	entry : {
		"bundle.js" : "./index"
	},
	module : {
		loaders : [
			// { test : /\.hbs/, loader : "handlebars-template-loader" }
		]
	},
	output : {
		path : __dirname + "/build/js",
		filename : "[name]"
	}
	// ,
	// node : {
	// 	fs : "empty"
	// }
};