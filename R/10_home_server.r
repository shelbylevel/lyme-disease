# ==============================================================================
# HOME/OVERVIEW MODULE - SERVER
# ==============================================================================

#' Overview Module Server
#'
#' @param id Module namespace ID
#'
#' @return Reactive values from the module
home_server <- function(id) {
  moduleServer(id, function(input, output, session) {
    ns <- session$ns
    
    # ------ OBSERVERS ---------------------------------------------------------
    
    # Navigate to Lyme Disease 101 tab when button clicked
    observeEvent(input$start_exploring, {
      updateNavbarPage(
        session = session$parent,
        inputId = "main_nav",
        selected = "Lyme Disease 101"
      )
    })
    
    # ------ RETURN VALUES -----------------------------------------------------
    
    return(NULL)
  })
}
