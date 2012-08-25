/*

loading yaml-markdowny files from disk into an article model

creates properties content and metadata from the yaml file

@author johann philipp strathausen <strathausen@gmail.com>
*/
var YamlMd, YamlMdDocument, buffer, ghm, yaml, yamlMd, _,
  __slice = Array.prototype.slice;

_ = require('underscore');

yaml = require('yamljs');

ghm = require('ghm');

YamlMdDocument = (function() {

  function YamlMdDocument(properties) {
    _.extend(this, properties);
  }

  return YamlMdDocument;

})();

YamlMd = (function() {

  function YamlMd() {}

  YamlMd.prototype.parse = function(content, properties) {
    var data, head, tail, _ref;
    if (properties == null) properties = {};
    _ref = content.split('\n\n'), head = _ref[0], tail = 2 <= _ref.length ? __slice.call(_ref, 1) : [];
    data = yaml.parse(head);
    data.html = ghm.parse(tail.join('\n\n'));
    return new YamlMdDocument(_.defaults(properties, data));
  };

  YamlMd.prototype.reader = function(fname, cb) {
    var _this = this;
    return fs.readFile(path.join(blog.dir, fname), 'utf8', function(err, content) {
      return cb(err, _this.parse(content, {
        id: fname
      }));
    });
  };

  return YamlMd;

})();

module.exports = new YamlMd;

yamlMd = require('./yamlMd');

buffer = [];

process.stdin.resume();

process.stdin.on('data', function(chunk) {
  return buffer.push(chunk);
});

process.stdin.on('end', function() {
  return process.stdout.write(JSON.stringify(yamlMd.parse(buffer.join(''))));
});
