compile:
	coffee -j index.js -bc lib/yamlMd.coffee
	coffee -j yamlmd2json.js -bc lib/yamlMdToJson.coffee
test:
	@node_modules/.bin/mocha -R spec \
	  --compilers coffee:coffee-script tests/*Tester.coffee
