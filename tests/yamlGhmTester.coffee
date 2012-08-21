yamlMardown = require '../lib/yamlGhm'
assert      = require 'assert'
fs          = require 'fs'
rawData     = fs.readFileSync __dirname + '/sampleArticle.md', 'utf8'
document    = {}

describe 'yamlGhm', ->
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
