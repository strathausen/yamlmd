###

loading yaml-markdowny files from disk into an article model

creates properties content and metadata from the yaml file

@author johann philipp strathausen <strathausen@gmail.com>

###
_       = require 'underscore'
yaml    = require 'yamljs'
ghm     = require 'ghm'

# Have a nice name for it!
class YamlMdDocument
  constructor: (properties) -> _.extend this, properties

class YamlMd
  parse: (content, properties={}) ->
    # split file content into yaml and markdown part
    [ head, tail... ] = content.split '\n\n'
    # parse yaml part (metadata)
    data = yaml.parse head
    # parse markdown part and render to html (content)
    data.html = ghm.parse tail.join '\n\n'
    # deliver the freshly baken article object
    new YamlMdDocument _.defaults properties, data

  # read a file's content
  # split into yaml and markdown part separated by two newlines \n\n
  # create a document
  reader: (fname, cb) ->
    fs.readFile (path.join blog.dir, fname), 'utf8', (err, content) =>
      cb err, @parse content, id: fname

module.exports = new YamlMd
