
module.exports = {
	entry : {
		"index.html" : "./index", 
		"main.js" : "./main"
	},
	loaders : [
		{ test : /\.hbs/, loader : "template-html-loader?engine=handlebars" }
	],
	output : {
		path : __dirname + "/build",
		filename : "[name]"
	}
};