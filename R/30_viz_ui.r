# ==============================================================================
# CLIMATE & RISK FACTORS MODULE - UI
# ==============================================================================

#' Risk Factors Module UI
#'
#' @param id Module namespace ID
#'
#' @return A Shiny UI element
risk_factors_ui <- function(id) {
  ns <- NS(id)

  bslib::layout_sidebar(
    # Sidebar for controls
    sidebar = bslib::sidebar(
      title = "Analysis Controls",
      width = 300,

      selectInput(
        ns("climate_factor"),
        "Climate Factor:",
        choices = c(
          "Average Temperature" = "temp",
          "Precipitation" = "precip",
          "Humidity" = "humidity",
          "Growing Season Length" = "season"
        ),
        selected = "temp"
      ),

      selectInput(
        ns("social_factor"),
        "Social Factor:",
        choices = c(
          "Population Density" = "pop_density",
          "Outdoor Recreation" = "recreation",
          "Forest Coverage" = "forest",
          "Urban Sprawl" = "sprawl"
        ),
        selected = "pop_density"
      ),

      sliderInput(
        ns("year_range"),
        "Year Range:",
        min = 2000,
        max = 2023,
        value = c(2010, 2023),
        step = 1,
        sep = ""
      ),

      hr(),

      h6("Key Climate Drivers:", class = "fw-bold"),
      tags$ul(
        class = "small",
        tags$li("Rising temperatures"),
        tags$li("Longer warm seasons"),
        tags$li("Changing precipitation patterns"),
        tags$li("Milder winters")
      )
    ),

    # Main content area
    bslib::layout_column_wrap(
      width = 1,

      # Page header
      bslib::card(
        bslib::card_body(
          class = "p-3",
          h2("Climate Change & Risk Factors", class = "mb-1"),
          p(
            "How environmental and social factors expand Lyme disease risk",
            class = "text-muted mb-0"
          )
        )
      ),

      # Climate impact explanation
      bslib::card(
        class = "bg-light",
        bslib::card_body(
          h4(
            "How Climate Change Affects Lyme Disease",
            class = "text-primary mb-3"
          ),
          fluidRow(
            column(
              width = 3,
              bslib::card(
                class = "border-0 shadow-sm",
                bslib::card_body(
                  class = "text-center",
                  icon("temperature-high", class = "fa-3x text-danger mb-2"),
                  h6("Warmer Temperatures"),
                  p(
                    "Extends tick active season and expands geographic range northward",
                    class = "small mb-0"
                  )
                )
              )
            ),
            column(
              width = 3,
              bslib::card(
                class = "border-0 shadow-sm",
                bslib::card_body(
                  class = "text-center",
                  icon("cloud-rain", class = "fa-3x text-primary mb-2"),
                  h6("Precipitation Changes"),
                  p(
                    "Alters habitat suitability and host animal populations",
                    class = "small mb-0"
                  )
                )
              )
            ),
            column(
              width = 3,
              bslib::card(
                class = "border-0 shadow-sm",
                bslib::card_body(
                  class = "text-center",
                  icon("snowflake", class = "fa-3x text-info mb-2"),
                  h6("Milder Winters"),
                  p(
                    "Increases tick survival rates through winter months",
                    class = "small mb-0"
                  )
                )
              )
            ),
            column(
              width = 3,
              bslib::card(
                class = "border-0 shadow-sm",
                bslib::card_body(
                  class = "text-center",
                  icon("leaf", class = "fa-3x text-success mb-2"),
                  h6("Ecosystem Changes"),
                  p(
                    "Affects deer and rodent populations that serve as tick hosts",
                    class = "small mb-0"
                  )
                )
              )
            )
          )
        )
      ),

      # Climate correlation chart
      bslib::card(
        full_screen = TRUE,
        bslib::card_header("Climate Factor vs. Lyme Disease Cases"),
        bslib::card_body(
          echarts4r::echarts4rOutput(
            ns("climate_correlation"),
            height = "400px"
          )
        )
      ),

      # Social factors chart
      bslib::card(
        full_screen = TRUE,
        bslib::card_header("Social & Environmental Risk Factors"),
        bslib::card_body(
          echarts4r::echarts4rOutput(ns("social_factors"), height = "400px")
        )
      ),

      # At-risk population analysis
      bslib::layout_column_wrap(
        width = 1 / 2,

        bslib::card(
          bslib::card_header("Expanding At-Risk Population"),
          bslib::card_body(
            h5("Population Groups at Increased Risk:", class = "mb-3"),
            bslib::card(
              class = "border-start border-warning border-4 mb-2",
              bslib::card_body(
                class = "py-2",
                h6("Outdoor Workers", class = "mb-1"),
                p(
                  "Landscapers, foresters, and agricultural workers face daily exposure",
                  class = "small mb-0"
                )
              )
            ),
            bslib::card(
              class = "border-start border-warning border-4 mb-2",
              bslib::card_body(
                class = "py-2",
                h6("Suburban Residents", class = "mb-1"),
                p(
                  "Urban sprawl brings more people into tick habitats",
                  class = "small mb-0"
                )
              )
            ),
            bslib::card(
              class = "border-start border-warning border-4 mb-2",
              bslib::card_body(
                class = "py-2",
                h6("Outdoor Enthusiasts", class = "mb-1"),
                p(
                  "Hikers, campers, and hunters in endemic areas",
                  class = "small mb-0"
                )
              )
            ),
            bslib::card(
              class = "border-start border-warning border-4 mb-2",
              bslib::card_body(
                class = "py-2",
                h6("Children", class = "mb-1"),
                p(
                  "More time playing outdoors, less aware of tick prevention",
                  class = "small mb-0"
                )
              )
            )
          )
        ),

        bslib::card(
          bslib::card_header("Climate-Driven Expansion"),
          bslib::card_body(
            bslib::value_box(
              title = "Temperature Increase",
              value = "+2.5°F",
              showcase = icon("temperature-arrow-up"),
              theme = "danger",
              p("Average warming since 1970 in Northeast", class = "fs-6")
            ),
            bslib::value_box(
              title = "Growing Season",
              value = "+2 weeks",
              showcase = icon("calendar-plus"),
              theme = "warning",
              p("Longer period for tick activity", class = "fs-6")
            ),
            bslib::value_box(
              title = "Geographic Shift",
              value = "150mi North",
              showcase = icon("arrow-up"),
              theme = "info",
              p("Northward tick range expansion", class = "fs-6")
            )
          )
        )
      )
    )
  )
}
