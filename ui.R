shinyUI(fluidPage(
  h3("JavaScript output binding example: Heatmap on Leaflet with Image as Layer"),
  fluidRow(
    column(width = 9,
           leafletHeatMapOutput("myheatmap")
    ),
    column(width = 3,
           numericInput("npoints", "# Points", value = 100, min = 10, max = 1000),
           actionButton("regenerate", "Generate Random Data")
    )
  )
))
