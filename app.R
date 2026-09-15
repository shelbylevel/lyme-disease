# ==============================================================================
# APP.R - Entrypoint
# ==============================================================================
# Lyme Disease and Climate Change Dashboard
# Entrypoint for Posit Connect Cloud / rsconnect publishing

source("global.r")
for (f in list.files("R", full.names = TRUE)) {
  source(f)
}
source("ui.r")
source("server.r")

shinyApp(ui = ui, server = server)
