# ==============================================================================
# UI.R - User Interface
# ==============================================================================
# Lyme Disease and Climate Change Dashboard
# This file contains the user interface structure

bslib::page_navbar(
  title = "Lyme Disease & Climate Dashboard",
  id = "main_nav",
  #fillable = TRUE, # Makes pages fill the viewport height

  # Set theme with Lyme disease colors
  theme = bslib::bs_theme(
    version = 5,
    primary = "#2E7D32",
    success = "#66BB6A",
    danger = "#EF5350",
    warning = "#FFA726",
    bg = "#FFFFFF",
    fg = "#1B1B1B"
  ),

  # ------ Custom CSS ------------------------------------------------------------
  header = tags$head(
    tags$style(HTML(
      "
      /* Remove fixed heights, let cards expand naturally to full height */
      .bslib-page-navbar .tab-content {
        height: auto !important;
        overflow-y: visible !important;
      }
      .card {
        height: auto !important;
        min-height: auto !important;
      }
      .card-body {
        height: auto !important;
        overflow-y: visible !important;
      }

      //* Ensure page scrolls normally */
      body, html {
        height: auto;
        overflow-y: auto;
      }
      
      /* Remove any flex constraints that force height */
      .bslib-page-navbar {
        height: auto !important;
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

      /* For layout_column_wrap, let items size naturally */
      .bslib-grid {
        height: auto !important;
      }
      .bslib-grid > .bslib-grid-item {
        height: auto !important;
      }
    "
    ))
  ),

  # Add custom CSS
  # includeCSS("www/css/main.min.css"),

  # ------ Tab 1: Overview -------------------------------------------------------
  # bslib::nav_panel(
  #   title = "Overview",
  #   icon = icon("house"),
  #   home_ui("home")
  # ),

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
    title = "Climate & Risk Factors",
    icon = icon("temperature-half"),
    risk_factors_ui("risk_factors")
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
          "Lyme Disease & Climate Dashboard",
          "<br>",
          "Shelby Level, MPA and Rachel Mauk, PhD • ",
          current_year
        )
      ),
      style = "margin: 0; color: #6c757d;"
    ),
    tags$p(
      "Data sources: CDC, NOAA, EPA",
      style = "margin: 5px 0 0 0; font-size: 0.85em; color: #6c757d;"
    )
  )
)
