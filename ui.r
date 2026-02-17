# ==============================================================================
# UI.R - User Interface
# ==============================================================================
# Lyme Disease and Climate Change Dashboard
# This file contains the user interface structure

bslib::page_navbar(
  title = "Lyme Disease in the United States",
  id = "main_nav",
  #fillable = TRUE, # Makes pages fill the viewport height

  # Set theme with Lyme disease colors
  theme = bslib::bs_theme(
    # preset = "shiny", # maybe sandstone
    brand = "www/sl-brand.yml"
  ),

  # ------ Custom CSS ------------------------------------------------------------
  # header = tags$head(
  #   tags$style(HTML(
  #     "

  #     /* Scrollytell specific styles */
  #     .scrolly-overlay {
  #       position: sticky;
  #       top: 0;
  #       height: 100vh;
  #       display: flex;
  #       align-items: center;
  #       justify-content: center;
  #     }

  #     .scrolly-section {
  #       min-height: 100vh;
  #       display: flex;
  #       align-items: center;
  #     }

  #     /* Grid layout adjustments */
  #     .bslib-grid {
  #       height: auto !important;
  #       align-items: start;
  #     }

  #     .bslib-grid > .bslib-grid-item {
  #       height: auto !important;
  #       min-height: auto !important;
  #     }

  #     .bslib-grid.grid {
  #       align-content: start;
  #     }

  #     [class*='bslib-mb-spacing'] {
  #       height: auto !important;
  #     }
  #   "
  #   ))
  # ),

  # Add custom CSS
  # includeCSS("www/css/main.min.css"),

  # ------ Tab 1: Overview -------------------------------------------------------
  bslib::nav_panel(
    title = "Home",
    icon = icon("house"),
    home_ui("home")
  ),

  # ------ Tab 2: Lyme Disease 101 ----------------------------------------------
  bslib::nav_panel(
    title = "Lyme Disease 101",
    icon = icon("book-medical"),
    education_ui("education")
  ),

  # ------ Tab 3: Geographic Distribution ---------------------------------------
  bslib::nav_panel(
    title = "Geographic Distribution",
    icon = icon("map-location-dot"),
    geography_ui("geography")
  ),

  # ------ Tab 4: Climate & Risk Factors ----------------------------------------
  bslib::nav_panel(
    title = "Climate & Environmental Risk",
    icon = icon("temperature-half"),
    climate_ui("climate")
  ),

  # ------ Tab 5: Public Health Impact ------------------------------------------
  bslib::nav_panel(
    title = "Public Health Impact",
    icon = icon("hospital"),
    public_health_ui("public_health")
  ),

  # ------ Footer ----------------------------------------------------------------
  footer = tags$div(
    class = "footer",
    style = "text-align: center; padding: 20px; border-top: 1px solid #ddd; background-color: #f8f9fa;",
    tags$p(
      HTML(
        paste(
          "Lyme Disease Dashboard Developed By:",
          "<br>",
          "Shelby Level, MPA and Rachel Mauk, PhD • ",
          current_year
        )
      ),
      style = "margin: 0; color: #6c757d;"
    ) # ,
    # tags$p(
    #   "Data sources: CDC, NOAA, EPA",
    #   style = "margin: 5px 0 0 0; font-size: 0.85em; color: #6c757d;"
    # )
  )
)
