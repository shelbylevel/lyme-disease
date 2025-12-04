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
      title = "Map Controls",
      width = 300,

      selectInput(
        ns("year"),
        "Select Year:",
        choices = 2010:2023,
        selected = 2023
      ),

      selectInput(
        ns("metric"),
        "Display Metric:",
        choices = c(
          "Total Cases" = "total_cases",
          "Cases per 100,000" = "rate",
          "Year-over-Year Change" = "change"
        ),
        selected = "rate"
      ),

      hr(),

      h6("Endemic States", class = "fw-bold"),
      p("States with historically high Lyme disease incidence:",
        class = "small text-muted"),
      tags$ul(
        class = "small",
        tags$li("Connecticut"),
        tags$li("Delaware"),
        tags$li("Maine"),
        tags$li("Maryland"),
        tags$li("Massachusetts"),
        tags$li("Minnesota"),
        tags$li("New Hampshire"),
        tags$li("New Jersey"),
        tags$li("New York"),
        tags$li("Pennsylvania"),
        tags$li("Rhode Island"),
        tags$li("Vermont"),
        tags$li("Virginia"),
        tags$li("Wisconsin")
      ),

      hr(),

      actionButton(
        ns("play_animation"),
        "Play Time Animation",
        icon = icon("play"),
        class = "btn-primary w-100"
      )
    ),

    # Main content area
    bslib::layout_column_wrap(
      width = 1,

      # Page header
      bslib::card(
        bslib::card_body(
          class = "p-3",
          h2("Geographic Distribution of Lyme Disease", class = "mb-1"),
          p("Visualizing the spread of Lyme disease across the United States",
            class = "text-muted mb-0")
        )
      ),

      # Map visualization
      bslib::card(
        full_screen = TRUE,
        bslib::card_header("US Map: Lyme Disease Cases by State"),
        bslib::card_body(
          echarts4r::echarts4rOutput(ns("us_map"), height = "550px")
        ),
        bslib::card_footer(
          class = "text-muted small",
          icon("info-circle"),
          " Click on states to see detailed information. Data shown is simulated for
          demonstration purposes."
        )
      ),

      # Trend over time
      bslib::card(
        bslib::card_header("Lyme Disease Trends Over Time"),
        bslib::card_body(
          echarts4r::echarts4rOutput(ns("trend_chart"), height = "400px")
        )
      ),

      # Key insights
      bslib::layout_column_wrap(
        width = 1/2,

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
