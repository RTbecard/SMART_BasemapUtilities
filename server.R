## Load libraries
require(rgdal)
require(raster)
require(dismo)

shinyServer(function(input, output) {
  ext <- reactive({
    extent(as.numeric(c(input$xmin,input$xmax,input$ymin,input$ymax)))
  })
  
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
      switch(mapType(), 
                  gmap(ext(),rgb = T,
                              scale = 2,
                              filename = file,
                              type = 'satellite'),
                  gmap(ext(),rgb = T,
                              scale = 2,
                              filename = file,
                              type = 'terrain')
      )
    }
  )
  
  output$plotMap <- renderPlot({
    map <- switch(mapType(), 
           plotRGB(gmap(ext(),rgb = T,scale = 2,type = 'satellite')),
           plotRGB(gmap(ext(),rgb = T,scale = 2,type = 'terrain')))
    }
  )
})