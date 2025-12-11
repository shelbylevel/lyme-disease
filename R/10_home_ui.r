# ==============================================================================
# HOME/OVERVIEW MODULE - UI
# ==============================================================================

#' Overview Module UI
#'
#' @param id Module namespace ID
#'
#' @return A Shiny UI element
home_ui <- function(id) {
  ns <- NS(id)

  bslib::layout_column_wrap(
    width = 1,
    #heights_equal = "row",

    # Page header with key message
    bslib::card(
      bslib::card_body(
        class = "p-4 text-center bg-light",
        h1(
          "Why Lyme Disease?",
          class = "mb-3"
        ),
        h4(
          "Understanding the expanding threat of tick-borne illness",
          class = "text-muted fw-normal mb-0"
        )
      ),
      bslib::card_body(
        p(
          class = "lead text-center",
          style = "margin-top: 10px;",
          "The CDC estimates that ~476,000 people may be diagnosed and treated for Lyme disease each year in the United States",
        )
      )
    ),

    # Key statistics row
    bslib::layout_column_wrap(
      width = 1 / 4,

      bslib::value_box(
        title = "Higher Incidence Rates",
        value = paste0("↑ ", round(inc_rate_incr, 1), "%"),
        showcase = icon("bug"),
        theme = "danger",
        p(
          "Incidence increase since 1996",
          class = "fs-6"
        )
      ),
      bslib::value_box(
        title = "High Incidence States",
        value = lyme_data %>%
          filter(
            (nchar(GEOID) == 2),
            ststatus == "High Incidence",
            year == 2023
          ) %>%
          count() %>%
          pull(n),
        showcase = icon("map-marked-alt"),
        theme = "warning",
        p("States with endemic Lyme", class = "fs-6")
      ),
      bslib::value_box(
        title = "Geographic Expansion",
        value = paste0("↑ ", round(cty_incr_since_2001, 1), "%"),
        showcase = icon("arrow-trend-up"),
        # showcase = highchartOutput(ns("cty_expansion"), height = "60px"),
        # showcase_layout = "bottom",
        # full_screen = TRUE,
        theme = "primary",
        p("County increase since 2001", class = "fs-6")
      ),
      bslib::value_box(
        title = "Climate Impact",
        value = "Rising",
        showcase = icon("temperature-high"),
        theme = "info",
        p("Warming extends tick season", class = "fs-6")
      )
    ),

    # Time series chart
    bslib::card(
      bslib::card_body(
        highchartOutput(ns("time_series"), height = "350px")
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
    ),

    # Dashboard overview
    bslib::layout_column_wrap(
      width = 1 / 2,

      bslib::card(
        bslib::card_header("About This Dashboard"),
        bslib::card_body(
          p(
            "This interactive dashboard explores the relationship between climate change and the 
            expanding geographic distribution of Lyme disease in the United States."
          ),
          tags$ul(
            tags$li(
              tags$b("Lyme Disease 101:"),
              " Learn about transmission, symptoms, and treatment"
            ),
            tags$li(
              tags$b("Geographic Distribution:"),
              " Visualize cases across states and time"
            ),
            tags$li(
              tags$b("Climate & Risk Factors:"),
              " Understand environmental drivers"
            ),
            tags$li(
              tags$b("Public Health Impact:"),
              " Examine implications for healthcare systems"
            )
          ),
          tags$hr(),
          p(
            class = "text-muted mb-0",
            "Navigate using the tabs above to explore each topic in detail."
          )
        )
      ),

      bslib::card(
        bslib::card_header("Key Findings"),
        bslib::card_body(
          bslib::card(
            class = "border-start border-danger border-4",
            bslib::card_body(
              class = "py-2",
              h6("Rising Incidence", class = "mb-1"),
              p(
                "Lyme disease is the most common vector-borne illness in the US, with cases 
                increasing dramatically over the past three decades.",
                class = "small mb-0"
              )
            )
          ),
          bslib::card(
            class = "border-start border-warning border-4",
            bslib::card_body(
              class = "py-2",
              h6("Geographic Expansion", class = "mb-1"),
              p(
                "Blacklegged ticks are spreading northward and westward, bringing Lyme disease 
                to previously unaffected regions.",
                class = "small mb-0"
              )
            )
          ),
          bslib::card(
            class = "border-start border-primary border-4",
            bslib::card_body(
              class = "py-2",
              h6("Climate Connection", class = "mb-1"),
              p(
                "Warmer temperatures and changing precipitation patterns are creating favorable 
                conditions for tick populations.",
                class = "small mb-0"
              )
            )
          )
        )
      )
    ),

    # Call to action
    # bslib::card(
    #   class = "bg-light",
    #   bslib::card_body(
    #     class = "text-center p-4",
    #     h5("Ready to explore the data?", class = "mb-3"),
    #     p(
    #       "Start with Lyme Disease 101 to understand the basics, then explore the geographic
    #       and climate trends.",
    #       class = "mb-3"
    #     ),
    #     actionButton(
    #       ns("start_exploring"),
    #       "Start Exploring",
    #       icon = icon("arrow-right"),
    #       class = "btn-primary btn-lg"
    #     )
    #   )
    # )
  )
}
