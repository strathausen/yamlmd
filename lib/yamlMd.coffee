###

loading yaml-markdowny files from disk into an article model

creates properties content and metadata from the yaml file

@author johann philipp strathausen <strathausen@gmail.com>

###
_       = require 'underscore'
yaml    = require 'yaml'
ghm     = require 'ghm'
mapStream = require 'map-stream'

# Have a nice name for it!
class YamlMdDocument
  constructor: (defaults) -> _.extend this, defaults

class YamlMd
  parse: (content, defaults={}) ->
    # split file content into yaml and markdown part
    [ head, tail... ] = content.split '\n\n'
    # parse yaml part (metadata)
    data = yaml.eval head
    # parse markdown part and render to html (content)
    data.html = ghm.parse tail.join '\n\n'
    # deliver the freshly baken article object
    new YamlMdDocument _.defaults defaults, data

  # read a file's content
  # split into yaml and markdown part separated by two newlines \n\n
  # create a document
  readFile: (fname, cb) =>
    fs.readFile (path.join blog.dir, fname), 'utf8', (err, content) =>
      cb err, @parse content, id: fname

  # return a stream that can read and write
  # @argument defaultData will be used as default data
  stream: (defaults) => mapStream (content, cb) =>
    cb null, @parse content.toString(), defaults

module.exports = new YamlMd
