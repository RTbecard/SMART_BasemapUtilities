## Load libraries
require(rgdal)
require(raster)
require(dismo)
require(ggmap)

shinyServer(function(input, output) {
  ext <- reactive({
    extent(as.numeric(c(input$xmin,input$xmax,input$ymin,input$ymax)))
  })

  ## Register google API key
  register_google(key = "insertGoogleKeyHere")
  message("Google API key accepted: " ,has_google_key())  

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
        return('Satellite.zip')
      } else{
        return('Topographic.zip')
      }
    },
    
    # This function should write data to a file given to it by
    # the argument 'file'.
    content = function(file){
      #browser()
      if(mapType()==1){ 
        gmap(ext(),rgb = T,
                    scale = 2,
                    filename = 'Satellite.gif',
                    type = 'satellite', googleAPIkey = google_key())
        zip(file,c('Satellite.gfw','Satellite.prj','Satellite.gif'))
      }else{
        gmap(ext(),rgb = T,
                    scale = 2,
                    filename = 'Topographic.gif',
                    type = 'terrain', googleAPIkey = google_key())
        zip(file,c('Topographic.gfw','Topographic.prj','Topographic.gif'))}
    }
    )
  
  output$plotMap <- renderPlot({
    map <- switch(mapType(), 
           plotRGB(gmap(ext(),rgb = T,scale = 2,type = 'satellite', googleAPIkey = google_key())),
           plotRGB(gmap(ext(),rgb = T,scale = 2,type = 'terrain', googleAPIkey = google_key())))
    }
  )
})

