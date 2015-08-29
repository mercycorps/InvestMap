(function() {
  window.MC || (window.MC = {});

  window.MC.Storage = {};

  window.MC.Classes = {};

  window.MC.Storage.regions = {
    header: $('header'),
    main: $('main'),
    map: $('#invest')
  };

}).call(this);
(function() {
  var Sequencer, Step, base, base1;

  (base = window.MC.Classes).Sequencer || (base.Sequencer = Sequencer = (function() {
    function Sequencer(map, offset) {
      var step;
      this.map = map;
      this.offset = offset;
      this.layers = [];
      this.steps = (function() {
        var i, len, ref, results;
        ref = $('main article.step');
        results = [];
        for (i = 0, len = ref.length; i < len; i++) {
          step = ref[i];
          results.push(new MC.Classes.Step($(step), this));
        }
        return results;
      }).call(this);
      this.map.done((function(_this) {
        return function(vis, layers) {
          return _this.setup(vis, layers);
        };
      })(this));
    }

    Sequencer.prototype.setup = function(vis, layers) {
      var i, layer, len, results;
      results = [];
      for (i = 0, len = layers.length; i < len; i++) {
        layer = layers[i];
        this.layers.push(layer);
        this.listen();
        results.push(this.poll());
      }
      return results;
    };

    Sequencer.prototype.listen = function() {
      return $(window).scroll((function(_this) {
        return function(e) {
          return _this.poll(e);
        };
      })(this));
    };

    Sequencer.prototype.poll = function(e) {
      var visible;
      visible = this.get_visible();
      if (visible !== this.current) {
        return this.activate(visible);
      }
    };

    Sequencer.prototype.activate = function(step) {
      var ref;
      if ((ref = this.current) != null) {
        ref.exit();
      }
      this.current = step;
      return this.current.enter();
    };

    Sequencer.prototype.get_visible = function() {
      var i, len, ref, step;
      ref = this.steps;
      for (i = 0, len = ref.length; i < len; i++) {
        step = ref[i];
        if (step.el.offset().top > ($(window).scrollTop() + this.offset)) {
          return step;
        }
      }
      return this.steps[0];
    };

    Sequencer.prototype.pan = function(lat, lng) {
      return this.map.map.setCenter([lat, lng]);
    };

    Sequencer.prototype.zoom = function(level) {
      return this.map.map.setZoom(level);
    };

    return Sequencer;

  })());

  (base1 = window.MC.Classes).Step || (base1.Step = Step = (function() {
    function Step(el, sequencer) {
      this.el = el;
      this.sequencer = sequencer;
      this.data = this.el.data();
    }

    Step.prototype.enter = function() {
      this.el.addClass('current');
      this.center();
      return console.log(this);
    };

    Step.prototype.exit = function() {
      this.el.removeClass('current');
      return console.log(this);
    };

    Step.prototype.center = function() {
      return this.sequencer.pan(this.data.lat, this.data.lng);
    };

    Step.prototype.zoom = function() {
      return this.sequencer.zoom(this.data.zoom);
    };

    return Step;

  })());

}).call(this);
(function() {
  MC.Storage.map = cartodb.createVis(MC.Storage.regions.map, MC.Storage.regions.map.data('map-url'));

  MC.Storage.sequencer = new MC.Classes.Sequencer(MC.Storage.map, Math.floor($(window).height() / 4));

}).call(this);
(function() {
  $(window).on('resize', function() {
    return $('main, .canvas').css('padding-top', $('header').outerHeight());
  });

  $(window).trigger('resize');

}).call(this);
