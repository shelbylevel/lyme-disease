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
      bslib::layout_column_wrap(
        width = NULL,
        style = css(grid_template_columns = "3fr 1fr"),
        bslib::card(
          full_screen = TRUE,
          bslib::card_body(
            highchartOutput(ns("us_map"), height = "550px") %>%
              shinycssloaders::withSpinner(type = 7, color = "#254D56")
          ),
          card_footer(
            "Sources: ",
            popover(
              a(
                "CDC (2025), U.S. Census Bureau (2025)",
                href = "javascript:void(0);"
              ),
              markdown(
                "Centers for Disease Control and Prevention. (2025). *Lyme Disease Case Maps*. [https://www.cdc.gov/lyme/data-research/facts-stats/lyme-disease-case-map.html](https://www.cdc.gov/lyme/data-research/facts-stats/lyme-disease-case-map.html) <br><br>
              U.S. Census Bureau. (2025). *Intercensal Population Estimates*. [https://www.census.gov/programs-surveys/popest/technical-documentation/research/intercensal-estimates.html](https://www.census.gov/programs-surveys/popest/technical-documentation/research/intercensal-estimates.html) <br><br>
              U.S. Census Bureau. (2025). *Population Estimates Program (PEP)*. [https://www.census.gov/programs-surveys/popest/data/tables.html](https://www.census.gov/programs-surveys/popest/data/tables.html)"
              )
            )
          )
        ),
        bslib::layout_column_wrap(
          width = 1,
          bslib::card(
            bslib::card_header(
              class = "bg-primary text-white",
              "Regional Patterns"
            ),
            bslib::card_body(
              tags$div(
                style = "margin-bottom: 1em;",
                icon("chart-line", class = "text-danger"),
                tags$b("Northeast:"),
                " Traditional endemic region; highest incidence."
              ),
              tags$div(
                style = "margin-bottom: 1em;",
                icon("arrow-trend-up", class = "text-warning"),
                tags$b("Upper Midwest:"),
                " Rapid expansion observed in recent years."
              ),
              tags$div(
                style = "margin-bottom: 1em;",
                icon("triangle-exclamation", class = "text-info"),
                tags$b("South & West:"),
                " New cases appearing in previously unaffected areas."
              )
            )
          ),
          # Key insights
          bslib::card(
            bslib::card_header(
              class = "bg-danger text-white",
              "Geographic Expansion"
            ),
            bslib::card_body(
              tags$ul(
                tags$li("Northward expansion from traditional endemic areas"),
                tags$li(
                  "Emergence in previously non-endemic Midwestern states"
                ),
                tags$li("Coastal regions show highest concentration"),
                tags$li("Western states reporting first confirmed cases")
              )
            )
          )
        )
      ),

      # Geographic expansion chart
      bslib::card(
        full_screen = TRUE,
        bslib::card_body(
          highchartOutput(ns("geo_expansion"), height = "350px") %>%
            shinycssloaders::withSpinner(type = 7, color = "#254D56")
        ),
        card_footer(
          "Source: ",
          popover(
            a("CDC (2025)", href = "javascript:void(0);"),
            markdown(
              "Centers for Disease Control and Prevention. (2025). *Lyme Disease Surveillance Data*. [https://www.cdc.gov/lyme/data-research/facts-stats/surveillance-data-1.html](https://www.cdc.gov/lyme/data-research/facts-stats/surveillance-data-1.html)"
            )
          )
        )
      )
    )
  )
}
