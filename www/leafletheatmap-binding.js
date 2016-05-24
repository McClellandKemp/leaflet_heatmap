// Put code in an Immediately Invoked Function Expression (IIFE).
// This isn't strictly necessary, but it's good JavaScript hygiene.
(function() {

  // See http://rstudio.github.io/shiny/tutorial/#building-outputs for
    // more information on creating output bindings.

  // First create a generic output binding instance, then overwrite
  // specific methods whose behavior we want to change.
  var binding = new Shiny.OutputBinding();

  binding.find = function(scope) {
    // For the given scope, return the set of elements that belong to
    // this binding.
    return $(scope).find(".leaflet-heat-map");
  };

  binding.renderValue = function(el, data) {
    // This function will be called every time we receive new output
    // values for a line chart from Shiny. The "el" argument is the
    // div for this particular chart.
    var $el = $(el);

    // The first time we render a value for a particular element, we
    // need to initialize the nvd3 line chart and d3 selection. We'll
    // store these on $el as a data value called "state".
    if (!$el.data("state")) {

      var map = L.map({
        minZoom: 1,
        maxZoom: 4,
        center: [-650, 270],
        zoom: 1,
        crs: L.CRS.Simple
      });

      // dimensions of the image
      var w = 4000,
          h = 5500,
          url = 'http://i.imgur.com/j6yH5E3.png';

      // calculate the edges of the image, in coordinate space
      var southWest = map.unproject([0, h], map.getMaxZoom()-1);
      var northEast = map.unproject([w, 0], map.getMaxZoom()-1);
      var bounds = new L.LatLngBounds(southWest, northEast);

      // add the image overlay so that it covers the entire map
      L.imageOverlay(url, bounds).addTo(map);

      // tell leaflet that the map is exactly as big as the image
      map.setMaxBounds(bounds);

      // Store the chart object on el so we can get it next time
      $el.data("state", {
        map: map
      });
    }

    var state = $el.data("state");

    var cmap = state.map;

    mdata = data.cmap(function (p) { return [p[0], p[1]]; });

    L.heatLayer(mdata, blur = 5).addTo(cmap);

    return cmap;
  };

  // Tell Shiny about our new output binding
  Shiny.outputBindings.register(binding, "leaflet_heatmap.leaflet-heat-map");

})();
