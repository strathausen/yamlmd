yamlMardown = require '../lib/yamlMd'
assert      = require 'assert'
fs          = require 'fs'
{ exec }    = require 'child_process'
rawData     = fs.readFileSync __dirname + '/sampleArticle.md', 'utf8'
document    = {}
dokiment    = {}

describe 'yamlMd', ->
  it 'should parse file content to document object', ->
    document = yamlMardown.parse rawData, id: 'sampleArticle'
    assert.equal typeof document, 'object'

  it 'document should have title as string', ->
    { title } = document
    assert typeof title is 'string'
    assert title.length > 20

  it 'document should have tags as array', ->
    { tags } = document
    assert typeof tags is 'object'
    assert tags.length > 0

  it 'document should have content as string', ->
    { html } = document
    assert typeof html is 'string'
    assert html.length > 10

  it 'document should have id as string', ->
    { id } = document
    assert typeof id is 'string'
    assert id.length > 0

describe 'yamlMdToJson', ->
  it 'pipe through', (done) ->
    command =
      "cat #{__dirname}/sampleArticle.md | #{__dirname}/../lib/yamlMdToJson.coffee
      --id sampleArticle"
    exec command, (err, stdout, stderr) ->
      dokiment = JSON.parse stdout
      assert.deepEqual dokiment, document
      do done
