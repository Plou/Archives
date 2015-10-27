//@ sourceMappingURL=columnManager.map
(function() {
  var column, columnManager, root, view, viewport;

  window.cManager || (window.cManager = {});

  window.cManager.column = column = (function() {
    function column(id, min, max, medium) {
      this.id = id;
      this.min = min;
      this.max = max;
      this.medium = medium;
      this.el = $('#' + this.id).css({
        'position': 'absolute',
        'display': 'block'
      });
    }

    return column;

  })();

  root = typeof exports !== "undefined" && exports !== null ? exports : window;

  root.cManager.column = column;

  columnManager = columnManager = (function() {
    function columnManager(id, columns, views, resizeEvent) {
      var index, _i, _len, _ref,
        _this = this;
      this.id = id;
      this.columns = columns;
      this.views = views;
      this.el = $('#' + this.id).css({
        'position': 'absolute',
        'top': '0',
        'right': '0',
        'bottom': '0',
        'left': '0'
      });
      this.view = this.views[0];
      this.gutter = 0;
      this.resizeEvent = resizeEvent ? resizeEvent + " viewChange" : "resize viewChange";
      this.viewport = new viewport;
      this.viewport.refreshVoid = function(gutter) {
        gutter = gutter ? gutter : _this.gutter;
        return _this.viewport["void"] = $(window).width() - gutter;
      };
      this.viewport.refreshVoid();
      _ref = this.columns;
      for (index = _i = 0, _len = _ref.length; _i < _len; index = ++_i) {
        column = _ref[index];
        column.index = index;
      }
      this.lastColumn = this.columns[this.columns.length - 1];
      this.lastColumn.el.css({
        'right': 0
      });
      this.refresh();
      $(window).on(this.resizeEvent, function() {
        return _this.refresh();
      });
    }

    columnManager.prototype.setPosition = function(column, gutter) {
      var cWidth;
      gutter = gutter ? gutter : this.gutter;
      cWidth = this.getSize(column.index);
      if (cWidth === "hide") {
        return column.el.hide();
      } else if (!cWidth) {
        column.el.hide();
        if (this.columns[this.lastColumn.index - 1]) {
          this.lastColumn = this.columns[this.lastColumn.index - 1];
        } else {
          this.lastColumn = this.columns[this.lastColumn.index];
        }
        this.lastColumn.el.css({
          'right': 0,
          'width': "auto"
        });
        return true;
      } else if (cWidth <= this.viewport["void"]) {
        column.el.show();
        column.el.css({
          'left': gutter,
          'right': column === this.lastColumn ? 0 : "auto",
          'width': column === this.lastColumn ? this.viewport["void"] : cWidth
        });
        this.gutter = cWidth + gutter;
        this.viewport.refreshVoid(this.gutter);
        return true;
      } else if (this.view.pointer + 1 < this.view.sizing.length) {
        this.view.pointer = this.view.pointer + 1;
        this.refresh(this.view.pointer);
        return false;
      } else {
        console.log("error no layout of the view :" + this.view.id + " could fit in the viewport last layout tried : " + this.view.sizing[this.view.pointer]);
        this.el.trigger("error", ["error no layout of the view :" + this.view.id + " could fit in the viewport last layout tried : " + this.view.sizing[this.view.pointer]]);
        return false;
      }
    };

    columnManager.prototype.refresh = function(pointer) {
      var index, _i, _len, _ref;
      this.gutter = 0;
      this.view.pointer = pointer ? pointer : 0;
      this.viewport.refresh();
      this.viewport.refreshVoid();
      this.lastColumn = this.columns[this.columns.length - 1];
      _ref = this.columns;
      for (index = _i = 0, _len = _ref.length; _i < _len; index = ++_i) {
        column = _ref[index];
        if (!this.setPosition(column, this.gutter)) {
          break;
        }
      }
      return this.el.trigger("updated");
    };

    columnManager.prototype.getSize = function(index) {
      return this.view.sizing[this.view.pointer][index];
    };

    columnManager.prototype.setView = function(id) {
      this.view = this.views[id];
      return $(window).trigger("viewChange");
    };

    columnManager.prototype.getColumn = function(id) {
      return this.columns[id];
    };

    columnManager.prototype.getView = function(id) {
      return this.views[id];
    };

    return columnManager;

  })();

  viewport = viewport = (function() {
    function viewport(width, height, _void) {
      this.width = width;
      this.height = height;
      this["void"] = _void;
      this.width = $(window).width();
      this.height = $(window).height();
    }

    viewport.prototype.refresh = function() {
      this.width = $(window).width();
      return this.height = $(window).height();
    };

    return viewport;

  })();

  root = typeof exports !== "undefined" && exports !== null ? exports : window;

  root.cManager.columnManager = columnManager;

  root.cManager.viewport = viewport;

  window.cManager || (window.cManager = {});

  window.cManager.view = view = (function() {
    function view(id, sizing) {
      this.id = id;
      this.sizing = sizing;
      this.pointer = 0;
    }

    return view;

  })();

  root = typeof exports !== "undefined" && exports !== null ? exports : window;

  root.cManager.view = view;

}).call(this);
