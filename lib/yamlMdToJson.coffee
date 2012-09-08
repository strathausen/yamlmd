###

Convet yaml annotated markdown to json

See `yamlmd2json --help` for details

###

program   = require 'commander'
yamlMd    = require '../'
mapStream = require 'map-stream'
path      = require 'path'
fs        = require 'fs'

buffer = []

program
  .description('Convert yaml annotated markdown to JSON. The markdown part will
    be converted to HTML. Uses stdin or a specified file as input.
      If the data is provided by a file, the base file name will be used as a default for the "id" property for the document.')
  .version('0.0.1')
  .option('-j, --json <json-data>', 'json data as default properties')
  .option('-f, --file <filename>', 'yaml annotated document ')
  .option('-i, --id <id>', 'the "id" property of the document')
  .option('-p, --pretty')
  .parse process.argv

if program.file
  sourceStream = fs.createReadStream program.file
else
  process.stdin.resume()
  sourceStream = process.stdin

if program.json
  defaults = JSON.parse program.json

defaults or= {}

if program.file
  defaults.id = path.basename program.file, path.extname program.file
else if program.id
  defaults.id = program.id

stringifier = mapStream (data, cb) ->
  cb null, JSON.stringify data, null, (program.pretty and 2)

sourceStream
  .pipe(yamlMd.stream defaults)
  .pipe(stringifier)
  .pipe(process.stdout)
