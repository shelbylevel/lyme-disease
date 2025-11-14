# ==============================================================================
# SERVER.R - Server Logic
# ==============================================================================
# Lyme Disease and Climate Change Dashboard
# This file contains the server function that handles app logic

function(input, output, session) {
  
  # ------ INITIALIZE ----------------------------------------------------------
  # Initialize session variables
  session$userData$app_started <- Sys.time()
  session$userData$dashboard_focus <- "lyme_climate"
  
  # ------ MODULES -------------------------------------------------------------
  
  # ------ * Overview Module ---------------------------------------------------
  home_server("home")
  
  # ------ * Lyme Disease 101 Module -------------------------------------------
  education_server("education")
  
  # ------ * Geographic Distribution Module ------------------------------------
  geography_server("geography")
  
  # ------ * Climate & Risk Factors Module -------------------------------------
  risk_factors_server("risk_factors")
  
  # ------ * Public Health Impact Module ---------------------------------------
  public_health_server("public_health")
  
  # ------ SESSION MANAGEMENT --------------------------------------------------
  # Handle app-wide events
  
  # Log session info
  session$onSessionEnded(function() {
    cat("Session ended at:", format(Sys.time()), "\n")
    cat("Dashboard focus:", session$userData$dashboard_focus, "\n")
  })
}
