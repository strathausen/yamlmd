/*

loading yaml-markdowny files from disk into an article model

creates properties content and metadata from the yaml file

@author johann philipp strathausen <strathausen@gmail.com>
*/
var YamlMarkdown, YamlMarkdownDocument, ghm, yaml, _,
  __slice = Array.prototype.slice;

_ = require('underscore');

yaml = require('yamljs');

ghm = require('ghm');

YamlMarkdownDocument = (function() {

  function YamlMarkdownDocument(properties) {
    _.extend(this, properties);
  }

  return YamlMarkdownDocument;

})();

YamlMarkdown = (function() {

  function YamlMarkdown() {}

  YamlMarkdown.prototype.parse = function(content, properties) {
    var data, head, tail, _ref;
    if (properties == null) properties = {};
    _ref = content.split('\n\n'), head = _ref[0], tail = 2 <= _ref.length ? __slice.call(_ref, 1) : [];
    data = yaml.parse(head);
    data.html = ghm.parse(tail.join('\n\n'));
    return new YamlMarkdownDocument(_.defaults(properties, data));
  };

  YamlMarkdown.prototype.reader = function(fname, cb) {
    var _this = this;
    return fs.readFile(path.join(blog.dir, fname), 'utf8', function(err, content) {
      return cb(err, _this.parse(content, {
        id: fname
      }));
    });
  };

  return YamlMarkdown;

})();

module.exports = new YamlMarkdown;
