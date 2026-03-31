library(shiny)
library(bslib)

ui <- page_navbar(
  title = htmltools::includeHTML("www/logo.svg"),
  theme = bs_theme(bootswatch = 'shiny'),
  nav_panel('Home', h3('Hello!'))
)

server <- function(input, output, session) {}

shinyApp(ui, server)
