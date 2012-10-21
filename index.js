// Generated by CoffeeScript 1.3.3
/*

Loading yaml-markdowny files from disk into an article model

Creates properties content and metadata from the yaml file

@author Johann Philipp Strathausen <strathausen@gmail.com>
*/

var YamlMd, YamlMdDocument, mapStream, md, yaml, _,
  __bind = function(fn, me){ return function(){ return fn.apply(me, arguments); }; },
  __slice = [].slice;

_ = require('underscore');

yaml = require('yaml');

md = require('marked');

mapStream = require('map-stream');

YamlMdDocument = (function() {

  function YamlMdDocument(defaults) {
    _.extend(this, defaults);
  }

  return YamlMdDocument;

})();

YamlMd = (function() {

  function YamlMd() {
    this.stream = __bind(this.stream, this);

    this.readFile = __bind(this.readFile, this);

  }

  YamlMd.prototype.parse = function(content, defaults) {
    var data, head, tail, yamlDoc, _ref;
    if (defaults == null) {
      defaults = {};
    }
    _ref = content.split('\n\n'), head = _ref[0], tail = 2 <= _ref.length ? __slice.call(_ref, 1) : [];
    yamlDoc = '---\n  ' + (head.replace(/\n/g, '\n  ')) + '\n';
    data = yaml["eval"](yamlDoc);
    data.html = md.parse(tail.join('\n\n'));
    return new YamlMdDocument(_.defaults(defaults, data));
  };

  YamlMd.prototype.readFile = function(fname, cb) {
    var _this = this;
    return fs.readFile(path.join(blog.dir, fname), 'utf8', function(err, content) {
      return cb(err, _this.parse(content, {
        id: fname
      }));
    });
  };

  YamlMd.prototype.stream = function(defaults) {
    var _this = this;
    return mapStream(function(content, cb) {
      return cb(null, _this.parse(content.toString(), defaults));
    });
  };

  YamlMd.prototype.marked = md;

  return YamlMd;

})();

module.exports = new YamlMd;
