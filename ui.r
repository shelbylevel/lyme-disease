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
    brand = "www/sl-brand.yml"
    # version = 5,
    # primary = "#727E70",
    # success = "#b2c5b4",
    # danger = "#59224A",
    # warning = "#FFA726",
    # bg = "#FFFFFF",
    # fg = "#1B1B1B"
  ),

  # ------ Custom CSS ------------------------------------------------------------
  header = tags$head(
    tags$style(HTML(
      "
      /* Remove flex from tab content */
      .tab-pane.html-fill-container {
        display: block !important;
      }
      
      /* Ensure inactive tabs are hidden */
      .tab-pane:not(.active) {
        display: none !important;
      }
      
      .tab-pane.active {
        display: block !important;
      }
      
      /* Remove equal-height rows in grid */
      .bslib-grid {
        grid-auto-rows: auto !important;
      }
      
      /* Remove gap spacing between grid items */
      .bslib-gap-spacing {
        gap: 0 !important;
      }
      
      /* Remove fixed heights, let cards expand naturally */
      .bslib-page-navbar .tab-content {
        height: auto !important;
        overflow-y: visible !important;
      }
      
      .card {
        height: auto !important;
        min-height: auto !important;
        max-height: none !important;
      }
      
      .card-body {
        height: auto !important;
        min-height: auto !important;
        overflow-y: visible !important;
      }
      
      /* Ensure page scrolls normally */
      body, html {
        height: auto;
        overflow-y: auto;
      }
      
      .bslib-page-navbar {
        height: auto !important;
        min-height: 100vh;
      }
      
      /* Scrollytell specific styles */
      .scrolly-overlay {
        position: sticky;
        top: 0;
        height: 100vh;
        display: flex;
        align-items: center;
        justify-content: center;
      }
      
      .scrolly-section {
        min-height: 100vh;
        display: flex;
        align-items: center;
      }
      
      /* Grid layout adjustments */
      .bslib-grid {
        height: auto !important;
        align-items: start;
      }
      
      .bslib-grid > .bslib-grid-item {
        height: auto !important;
        min-height: auto !important;
      }
      
      .bslib-grid.grid {
        align-content: start;
      }
      
      [class*='bslib-mb-spacing'] {
        height: auto !important;
      }
    "
    ))
  ),

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
  # bslib::nav_panel(
  #   title = "Public Health Impact",
  #   icon = icon("hospital"),
  #   public_health_ui("public_health")
  # ),

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
