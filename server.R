shinyServer(function(input, output, session) {

  plotdata <- eventReactive(input$regenerate, {
    validate(
      need(input$npoints, "Select # of points to plot!")
    )
    n <- input$npoints
    data.frame(x = runif(n), y = runif(n))
  })

  output$myheatmap <- renderLeafletHeatMap({
    plotdata()
  })

})
