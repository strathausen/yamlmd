# Yaml M.D.

``` bash
$ echo 'title: Latest news\n\n#Latest news' | yamlmd2json
{"title":"Latest news","html":"<h1>Latest news</h1>"}
```

`yamlmd` is a node module and a command line utility that generates JSON documents by parsing YAML annotated Markdown files. Github flavoured Markdown is being used to parse the markdown part.

## Input format

The input format is loosely compatible to the Django "nest" framework: some YAML metadata and Markdown seperated by two newline characters.

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

### As a module

```javascript
var yamlmd = require('yamlmd');
yamlmd.parse('title: Latest news\n\n#Latest news');
```

#### yamlmd.parse(text[, data])
#### yamlmd.stream([data])
