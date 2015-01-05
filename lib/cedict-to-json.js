#!/usr/local/bin/node

var readline = require('readline');
var rl = readline.createInterface({
  input: process.stdin,
  output: new require('stream')
});

var isGood = function(line) {
	return !/(^#)|(variant\sof)|(Suzhou numeral)/.test(line);
};

var regex = /^(.*?)\s(.*?)\s\[(.*?)\](.*)/;

console.log('[');

rl.on('line', function(line) {
	if (isGood(line)) {
		var parts = regex.exec(line);
		if (parts) {
			var o = {
				character: parts[2],
				size: parts[2].length,
				pinyin: parts[3],
				definitions: parts[4].split('\/').filter(function(a){ return !!a && !!a.trim(); })
			};
			console.log(JSON.stringify(o));
			console.log(',');
		}
	}
})

rl.on('end', function() {
	console.log(']');
});