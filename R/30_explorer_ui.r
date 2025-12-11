# ==============================================================================
# GEOGRAPHIC DISTRIBUTION MODULE - UI (with Scrollytelling)
# ==============================================================================

#' Geographic Distribution Module UI
#'
#' @param id Module namespace ID
#'
#' @return A Shiny UI element
geography_ui <- function(id) {
  ns <- NS(id)

  tagList(
    # Use scrollytell for narrative-driven exploration
    scrollytell::scrolly_container(
      outputId = ns("scr"),

      # Scrollytelling sections on the left
      scrollytell::scrolly_sections(
        # Section 1: Introduction
        scrollytell::scrolly_section(
          id = "section1",
          class = "scrolly-section",
          div(
            class = "p-5",
            h2("The Geographic Story of Lyme Disease", class = "mb-4"),
            p(
              class = "lead",
              "Lyme disease has been steadily expanding across the United States. 
              Let's explore how this vector-borne illness has spread beyond its 
              traditional strongholds."
            ),
            p(
              "Scroll down to see the geographic distribution and trends over time."
            )
          )
        ),

        # Section 2: Current Distribution
        scrollytell::scrolly_section(
          id = "section2",
          class = "scrolly-section",
          div(
            class = "p-5",
            h3("Current Distribution", class = "mb-3 text-primary"),
            p(
              class = "lead",
              "The Northeast and Upper Midwest remain hotspots."
            ),
            tags$ul(
              tags$li(
                tags$b("High Endemic:"),
                " Pennsylvania, New York, New Jersey, 
                      Connecticut, Massachusetts"
              ),
              tags$li(
                tags$b("Growing Risk:"),
                " Wisconsin, Minnesota, Virginia, Maryland"
              ),
              tags$li(
                tags$b("Emerging:"),
                " Southern and Western states reporting first cases"
              )
            ),
            selectInput(
              ns("year_scrolly"),
              "Select Year:",
              choices = 2010:2023,
              selected = 2023,
              width = "200px"
            )
          )
        ),

        # Section 3: Temporal Trends
        scrollytell::scrolly_section(
          id = "section3",
          class = "scrolly-section",
          div(
            class = "p-5",
            h3("Rising Incidence Over Time", class = "mb-3 text-danger"),
            p(class = "lead", "Cases have increased dramatically since 2010."),
            p(
              "The five states with the highest burden show consistent upward trends, 
              with some states experiencing exponential growth in recent years."
            ),
            tags$ul(
              tags$li("2010-2015: Steady baseline increases"),
              tags$li("2015-2020: Accelerated growth period"),
              tags$li("2020-2023: New peak levels reached")
            )
          )
        ),

        # Section 4: Regional Patterns
        scrollytell::scrolly_section(
          id = "section4",
          class = "scrolly-section",
          div(
            class = "p-5",
            h3("Regional Expansion Patterns", class = "mb-3 text-warning"),
            p(class = "lead", "The disease is moving into new territories."),
            div(
              class = "row",
              div(
                class = "col-md-6",
                h5("Northeast", class = "text-danger"),
                p(
                  "Traditional endemic region maintaining high case counts with 
                  slight geographical expansion northward into Maine and Vermont."
                )
              ),
              div(
                class = "col-md-6",
                h5("Upper Midwest", class = "text-warning"),
                p(
                  "Most dramatic expansion, with Wisconsin and Minnesota seeing 
                  300%+ increases in affected counties."
                )
              )
            ),
            div(
              class = "row mt-3",
              div(
                class = "col-md-6",
                h5("South", class = "text-info"),
                p(
                  "Virginia and North Carolina reporting steady increases, suggesting 
                  southward tick population expansion."
                )
              ),
              div(
                class = "col-md-6",
                h5("West", class = "text-success"),
                p(
                  "Isolated cases appearing in previously non-endemic Western states, 
                  indicating potential for further spread."
                )
              )
            )
          )
        ),

        # Section 5: Future Outlook
        scrollytell::scrolly_section(
          id = "section5",
          class = "scrolly-section",
          div(
            class = "p-5",
            h3("What This Means for the Future", class = "mb-3 text-dark"),
            p(
              class = "lead",
              "Geographic expansion shows no signs of slowing."
            ),
            tags$ul(
              tags$li(
                tags$b("Climate-Driven:"),
                " Warmer temperatures enable tick 
                      survival in new regions"
              ),
              tags$li(
                tags$b("Population Movement:"),
                " Suburban expansion brings more 
                      people into contact with tick habitats"
              ),
              tags$li(
                tags$b("Healthcare Challenge:"),
                " Medical systems in new areas 
                      must prepare for diagnosis and treatment"
              ),
              tags$li(
                tags$b("Prevention Critical:"),
                " Public awareness and tick 
                      control measures are increasingly important"
              )
            ),
            actionButton(
              ns("explore_climate"),
              "Explore Climate Factors →",
              class = "btn-primary btn-lg mt-3"
            )
          )
        )
      ),

      # Sticky visualization on the right
      scrollytell::scrolly_overlay(
        bslib::card(
          class = "full-height-card",
          full_screen = TRUE,
          bslib::card_body(
            uiOutput(ns("map_output"))
          )
        )
      )
    )
  )
}
