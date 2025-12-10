# ==============================================================================
# GEOGRAPHIC DISTRIBUTION MODULE - UI
# ==============================================================================

#' Geographic Distribution Module UI
#'
#' @param id Module namespace ID
#'
#' @return A Shiny UI element
geography_ui <- function(id) {
  ns <- NS(id)

  bslib::layout_sidebar(
    # Sidebar for controls
    sidebar = bslib::sidebar(
      title = "Map Options",
      width = 300,
      open = TRUE,

      selectInput(
        ns("geography"),
        "Geography of Interest:",
        choices = available_geos,
        selected = available_geos[1]
      ),

      selectInput(
        ns("geo_level"),
        "Geography Level:",
        choices = c("County", "State"),
        selected = "County"
      ),

      sliderInput(
        ns("year"),
        "Select Year:",
        min = min(available_years, na.rm = TRUE),
        max = max(available_years, na.rm = TRUE),
        value = max(available_years, na.rm = TRUE),
        step = 1,
        sep = "" # removes thousands separator for years
      ),

      # actionButton(
      #   ns("play_animation"),
      #   "Play Time Animation",
      #   icon = icon("play"),
      #   class = "btn-primary w-100"
      # )
    ),

    # Main content area
    bslib::layout_column_wrap(
      width = 1,

      # Page header
      bslib::card(
        bslib::card_body(
          class = "p-4 bg-light",
          h2("Where Does Lyme Disease Occur?", class = "mb-3"),
          h4(
            "Visualizing the spread of Lyme disease across the United States",
            class = "text-muted fw-normal mb-0"
          )
        )
      ),

      # Map visualization
      bslib::card(
        full_screen = TRUE,
        # bslib::card_header(paste("Lyme Disease Cases in", input$year)),
        bslib::card_body(
          highchartOutput(ns("us_map"), height = "550px") %>%
            shinycssloaders::withSpinner(type = 7, color = "#254D56")
        ),
        card_footer(
          "Sources: ",
          popover(
            a("CDC (2025), U.S. Census Bureau (2025)", href = "#"),
            markdown(
              "Centers for Disease Control and Prevention. (2025). *Lyme Disease Case Maps*. [https://www.cdc.gov/lyme/data-research/facts-stats/lyme-disease-case-map.html](https://www.cdc.gov/lyme/data-research/facts-stats/lyme-disease-case-map.html) <br><br>
              U.S. Census Bureau. (2025). *Intercensal Population Estimates*. [https://www.census.gov/programs-surveys/popest/technical-documentation/research/intercensal-estimates.html](https://www.census.gov/programs-surveys/popest/technical-documentation/research/intercensal-estimates.html) <br><br>
              U.S. Census Bureau. (2025). *Population Estimates Program (PEP)*. [https://www.census.gov/programs-surveys/popest/data/tables.html](https://www.census.gov/programs-surveys/popest/data/tables.html)"
            )
          )
        )
        # bslib::card_footer(
        #   class = "text-muted small",
        #   icon("info-circle"),
        #   " Click on states to see detailed information. Data shown is simulated for
        #   demonstration purposes."
        # )
      ),

      # Geographic expansion chart
      bslib::card(
        full_screen = TRUE,
        # bslib::card_header(paste("Lyme Disease Cases in", input$year)),
        bslib::card_body(
          highchartOutput(ns("geo_expansion"), height = "350px")
        ),
        card_footer(
          "Source: ",
          popover(
            a("CDC (2025)", href = "#"),
            markdown(
              "Centers for Disease Control and Prevention. (2025). *Lyme Disease Surveillance Data*. [https://www.cdc.gov/lyme/data-research/facts-stats/surveillance-data-1.html](https://www.cdc.gov/lyme/data-research/facts-stats/surveillance-data-1.html)"
            )
          )
        )
      ),

      # Key insights
      bslib::layout_column_wrap(
        width = 1 / 2,

        bslib::card(
          bslib::card_header("Geographic Expansion"),
          bslib::card_body(
            h5("Key Observations:", class = "text-primary"),
            tags$ul(
              tags$li("Northward expansion from traditional endemic areas"),
              tags$li("Emergence in previously non-endemic Midwestern states"),
              tags$li("Coastal regions show highest concentration"),
              tags$li("Some Western states reporting first confirmed cases")
            )
          )
        ),

        bslib::card(
          bslib::card_header("Regional Patterns"),
          bslib::card_body(
            bslib::value_box(
              title = "Northeast",
              value = "Highest",
              showcase = icon("chart-line"),
              theme = "danger",
              p("Traditional endemic region", class = "fs-6")
            ),
            bslib::value_box(
              title = "Upper Midwest",
              value = "Rising",
              showcase = icon("arrow-trend-up"),
              theme = "warning",
              p("Rapid expansion observed", class = "fs-6")
            ),
            bslib::value_box(
              title = "South & West",
              value = "Emerging",
              showcase = icon("triangle-exclamation"),
              theme = "info",
              p("New cases appearing", class = "fs-6")
            )
          )
        )
      )
    )
  )
}
