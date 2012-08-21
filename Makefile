test:
	@node_modules/.bin/mocha -R spec \
	  --compilers coffee:coffee-script tests/*Tester.coffee
compile:
	@coffee -j index.js -bc lib/*
