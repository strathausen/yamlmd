# Yaml M.D.


`yamlmd` is a node module and a command line utility that generates JSON documents by parsing YAML annotated Markdown files.

## Input format

The input format is loosely compatible to the Django "nest" framework: some YAML metadata and Markdown seperated by three newline characters.

``` markdown
title: This title will become a JSON property


# This title will be rendered as HTML
```

## Installation

To use it as a module in node, type

`npm i yamlmd`

To use it as a command line utility, one should install it globally

`npm i yamlmd -g`

## Usage

You may see the test suite on how to use it.

### As a module

``` js
var yamlmd = require('yamlmd');
yamlmd.parse('title: Latest news\n\n#Latest news');
```

#### yamlmd.parse(text[, data])

Arguments:

`text` the raw yaml-markdown document.

`data` (optional) default properties that might get overwritten by properties defined in the raw document.

returns a JSON object whereas the property `html` contains the html version of the markdown part of the original raw document.

#### yamlmd.stream([data])

Arguments:

`data` (optional) default properties that might get overwritten by properties defined in the raw document.

returns a stream object that you can use to `pipe` data through it, e.g.

``` javascript
fileStream
  .pipe(yamlmd.stream({id:'myDoc'})
  .pipe(toJson)
  .pipe(process.stdout);
```

### As a command line utility

If the directory `node_modules/.bin/` is in your path, you can use it like this:

``` bash
$ echo 'title: Latest news\n\n\n#Latest news' | yamlmd2json
{"title":"Latest news","html":"<h1>Latest news</h1>"}
```

and find out more about its options with `--help`

``` bash
yamlmd2json --help
```
