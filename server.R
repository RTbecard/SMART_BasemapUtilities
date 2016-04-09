## Load libraries
require(rgdal)
require(raster)
require(dismo)

shinyServer(function(input, output) {
  mapType <- reactive({
    # Fetch the appropriate data object, depending on the value
    # of input$dataset.
    return(switch(input$type,
           "Satellite" = 1,
           "Topographic" = 2))
  })
  
  
  # downloadHandler() takes two arguments, both functions.
  # The content function is passed a filename as an argument, and
  #   it should write out data to that filename.
  output$downloadData <- downloadHandler(
    
    # Define file name for browser to save as
    filename = function() {
      if(mapType() == 1){
        return('Satellite.gif')
      } else{
        return('Topographic.gif')
      }
    },
    
    # This function should write data to a file given to it by
    # the argument 'file'.
    content = function(file) {
      e <- extent(as.numeric(c(input$xmin,input$xmax,input$ymin,input$ymax)))
      switch(mapType(), 
                  gmap(e,rgb = T,
                              scale = 2,
                              filename = file,
                              type = 'satellite',
                              size = c(as.numeric(input$w),as.numeric(input$h))),
                  gmap(e,rgb = T,
                              scale = 2,
                              filename = file,
                              type = 'terrain',
                              size = c(as.numeric(input$w),as.numeric(input$h)))
      )
    }
  )
  
  output$plotMap <- renderPlot({
    e <- extent(as.numeric(c(input$xmin,input$xmax,input$ymin,input$ymax)))
    map <- switch(mapType(), 
           plotRGB(gmap(e,rgb = T,scale = 1,type = 'terrain')),
           plotRGB(gmap(e,rgb = T,scale = 2,type = 'satellite')))
    }
  )
})