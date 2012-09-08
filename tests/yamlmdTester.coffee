yamlMardown = require '../lib/yamlMd'
assert      = require 'assert'
fs          = require 'fs'
{ exec, execFile } = require 'child_process'
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

  it 'document should have html as string', ->
    { html } = document
    assert typeof html is 'string'
    assert html.length > 10

  it 'document should have id as string', ->
    { id } = document
    assert typeof id is 'string'
    assert id.length > 0

  it 'document should have id as string', ->
    { id } = document
    assert typeof id is 'string'
    assert id.length > 0

describe 'yamlMdToJson', ->
  it 'pipe through, json property', (done) ->
    command =
      "cat #{__dirname}/sampleArticle.md | coffee #{__dirname}/../lib/yamlMdToJson.coffee
      --json '{\"id\":\"sampleArticle\"}'"
    exec command, (err, stdout, stderr) ->
      dokiment = JSON.parse stdout
      assert.deepEqual dokiment, document
      do done

  it 'pipe through, id property', (done) ->
    command =
      "cat #{__dirname}/sampleArticle.md | coffee #{__dirname}/../lib/yamlMdToJson.coffee
      --id sampleArticle"
    exec command, (err, stdout, stderr) ->
      dokiment = JSON.parse stdout
      assert.deepEqual dokiment, document
      do done

  it 'file provided', (done) ->
    command = 'coffee'
    args = [ "#{__dirname}/../lib/yamlMdToJson.coffee", '--file',
      "#{__dirname}/sampleArticle.md" ]
    execFile command, args, (err, stdout, stderr) ->
      dokiment = JSON.parse stdout
      assert.deepEqual dokiment, document
      do done
