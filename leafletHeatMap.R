leafletHeatMapOutput <- function(inputId, width="100%", height="400px") {
  style <- sprintf("width: %s; height: %s;",
                   validateCssUnit(width), validateCssUnit(height))

  tagList(
    singleton(
      tags$head(
        tags$link(rel = "stylesheet", type = "text/css",
                  href = "http://cdn.leafletjs.com/leaflet/v0.7.7/leaflet.css"),
        tags$link(rel = "stylesheet",
                  href = "https://maxcdn.bootstrapcdn.com/bootstrap/3.3.6/css/bootstrap.min.css",
                  integrity = "sha384-1q8mTJOASx8j1Au+a5WDVnPi2lkFfwwEAa8hDDdjZlpLegxhjVME1fgjWPGmkzs7",
                  crossorigin = "anonymous"),
        tags$script(src = "https://maxcdn.bootstrapcdn.com/bootstrap/3.3.6/js/bootstrap.min.js",
                    integrity = "sha384-0mSbJDEHialfmuBBQP6A4Qrprq5OVfW37PRR3j5ELqxss1yVqOtnepnHVP9aJ7xS",
                    crossorigin = "anonymous"),
        tags$script(src = "http://cdn.leafletjs.com/leaflet/v0.7.7/leaflet.js"),
        tags$script(src = "plugins/Leaflet.heat-gh-pages/dist/leaflet-heat.js"),
        tags$script(src = "leafletheatmap-binding.js"),
        tags$style(type = "text/css",
                   "#leaflet-heat-map {
                     width: 100%;
                     height: 700px;
                     border: 1px solid #ccc;
                     margin-bottom: 10px;
                    }")
        )
      ),
    div(id = inputId, class = "leaflet-heat-map", style = style)
    )
  }

renderLeafletHeatMap <- function(expr, env = parent.frame(), quoted = FALSE) {
  installExprFunction(expr, "func", env, quoted)

  function() {
    dataframe <- func()
    apply(dataframe, 1, as.list)
  }
}
# Data frame or list looks like:
#
# {
#   "x": [1,2,3,4,5],
#   "y": [6,7,8,9,10]
# }
#
# Leaflet expects:
#
# [
#   [x:1, y:6], [x:2, y:7], [x:3, y:8], [x:4, y:9], [x:5, y:10]
# ]
