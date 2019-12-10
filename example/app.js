// This is a test harness for your module
// You should do something interesting in this harness
// to test out the module and to provide instructions
// to users on how to use it by example.

var tistoreproductsquirrel = require('fr.squirrel.tistoreproductview');
Ti.API.info("module is => " + tistoreproductsquirrel);

var window = Ti.UI.createWindow({
	layout:'vertical'
});

var faceBook = Ti.UI.createButton({
	top:50,
	title:'Show Facebook',
	font:{
		fontSize:15
	},
	width:150,
	height:Ti.UI.SIZE,
});
window.add(faceBook);

var twitter = Ti.UI.createButton({
	top:50,
	title:'Show Twitter',
	font:{
		fontSize:15
	},
	width:150,
	height:Ti.UI.SIZE,
});
window.add(twitter);

faceBook.addEventListener('click', function(e){
	tistoreproductsquirrel.showApp({
		appId:284882215,
		success:function(e){
			Ti.API.info("loaded successfully.");
		},
		error:function(e){
			Ti.API.info("loaded failed.");
		},
		closed:function(e){
			Ti.API.info("product view closed.");
		}
	});
});

twitter.addEventListener('click', function(e){
	tistoreproductsquirrel.showApp({
		appId:333903271,
		animated:false,
		success:function(e){
			Ti.API.info("loaded successfully.");
		},
		error:function(e){
			Ti.API.info("loaded failed.");
		},
		closed:function(e){
			Ti.API.info("product view closed.");
		}
	});
});

window.open();
