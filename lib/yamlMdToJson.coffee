###

Convet yaml annotated markdown to json

See `yamlmd2json --help` for details

###

program = require 'commander'
yamlMd = require './yamlMd'
mapStream = require 'map-stream'

buffer = []

program
  .description('Convert yaml annotated markdown to JSON. The markdown part will
    be converted to HTML. Uses stdin or a specified file as input.')
  .option('-j, --json <json-data>', 'json data as default properties')
  .option('-J, --jsonfile', 'a json file containing default properties')
  .option('-f, --file <filename>', 'yaml annotated document ')
  .option('-i, --id', 'the ID property of the document')
  .option('-p, --pretty')
  .parse process.argv

if program.file
  sourceStream = fs.readFileStream program.file
else
  process.stdin.resume()
  sourceStream = process.stdin

stringifier = mapStream (data, cb) ->
  cb null, JSON.stringify data, null, (program.pretty and 2)

sourceStream
  .pipe(yamlMd.stream())
  .pipe(stringifier)
  .pipe(process.stdout)
