.PHONY: test

compile:
	coffee -j index.js -bc lib/yamlMd.coffee
	coffee -j bin/yamlmd2json.js -bc lib/yamlMdToJson.coffee
	chmod +x bin/yamlmd2json.js
	echo '0a\n#!/usr/bin/env node\n.\nw' | ed bin/yamlmd2json.js
test:
	@node_modules/.bin/mocha test/*Tester.coffee
