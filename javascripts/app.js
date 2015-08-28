(function() {
  window.MC || (window.MC = {});

  window.MC.Storage = {};

  window.MC.Storage.regions = {
    header: $('header'),
    main: $('main'),
    map: $('#invest')
  };

}).call(this);
(function() {
  MC.Storage.map = cartodb.createVis(MC.Storage.regions.map, MC.Storage.regions.map.data('map-url'));

}).call(this);
(function() {
  $(window).on('resize', function() {
    return $('main, .canvas').css('padding-top', $('header').outerHeight());
  });

  $(window).trigger('resize');

}).call(this);
