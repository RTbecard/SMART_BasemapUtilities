shinyUI(fluidPage(
  titlePanel('SMART Basemap Utility',windowTitle = 'SMART Basemap Utility'),
  sidebarLayout(
    sidebarPanel(
      h4('Instructions'),
      p("This application will automatically create graphical layers which can be used in SMART conservation area basemaps.  Enter the geographic extent of your conservation area (in decimal degrees), then press \'download\' to save the map as a georeferenced image which can be imported by SMART."),
      h4('File types'),
      p('Resulting images are saved as georeferenced GIF files.'),
      selectInput("type", "Choose a map type:", 
                  choices = c("Satellite", "Topographic")),
      downloadButton('downloadData', 'Download')
    ),
      mainPanel(      
        fluidRow(column(width = 12,
                        h4('Basemap Longitude Range'))),
        fluidRow(column(width = 6,
                        textInput('xmin','Minimum',value = 11.03,width = 250)),
                 column(width = 6,
                        textInput('xmax','Maximum',value = 12,width = 250))),
        fluidRow(column(width = 12,
                        h4('Basemap Latitude Range'))),
        fluidRow(column(width = 6,
                        textInput('ymin','Minimum',value = -1.1,width = 250)),
                 column(width = 6,
                        textInput('ymax','Maximum',value = -0.04,width = 250))),
        fluidRow(column(width = 12,
                        plotOutput("plotMap")))
        )
    )
  )
)

