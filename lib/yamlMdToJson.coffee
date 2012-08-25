#!/usr/bin/env coffee

###

Convet yaml annotated markdown into json

See `yamlmd2json --help` for details

###

program = require 'commander'
yamlMd = require './yamlMd'

buffer = []


program
  .option('-J, --json <json-data>',
    'json data as default properties')
  .command('[file]')
  .action (fName) ->
    console.error 'getting here'
    console.error fName
    return unless fNmme

    process.stdin.resume()

    process.stdin.on 'data', (chunk) ->
      buffer.push chunk

    process.stdin.on 'end', ->
      return unless buffer.length
      process.stdout.write JSON.stringify yamlMd.parse buffer.join ''

program.parse process.argv
