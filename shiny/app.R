library(shiny)
library(googleway)

ui <- fluidPage(
  sliderInput(inputId = "opacity", label = "opacity", min = 0, max = 1, 
              step = 0.01, value = 1),
  google_mapOutput(outputId = "map")
)

server <- function(input, output){
  
  # set google map API key from environment variable
  map_key <- googleway::set_key(key = Sys.getenv("GOOGLE_MAP_KEY"))
  
  output$map <- renderGoogle_map({
    
    google_map(key = map_key) %>%
      add_polygons(data = melbourne, id = "polygonId", pathId = "pathId", 
                   polyline = "polyline", fill_opacity = 1)
  })
  
  ## observe the opacity slider changing
  observeEvent(input$opacity, {
    
    melbourne$opacity <- input$opacity
    
    google_map_update(map_id = "map") %>%
      update_polygons(data = melbourne, fill_opacity = "opacity", id = "polygonId")
  })
  
}

shinyApp(ui, server)