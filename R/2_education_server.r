# ==============================================================================
# LYME DISEASE 101 MODULE - SERVER
# ==============================================================================

#' Lyme Disease Education Module Server
#'
#' @param id Module namespace ID
#'
#' @return Reactive values from the module
education_server <- function(id) {
  moduleServer(id, function(input, output, session) {
    ns <- session$ns
    
    # ------ REACTIVE ----------------------------------------------------------
    # This module is primarily informational, so minimal reactive content needed
    
    # ------ RETURN VALUES -----------------------------------------------------
    return(NULL)
  })
}
