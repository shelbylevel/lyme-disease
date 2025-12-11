# ==============================================================================
# CLIMATE & ENVIRONMENTAL RISK FACTORS MODULE - UI
# ==============================================================================

#' Climate Module UI
#'
#' @param id Module namespace ID
#'
#' @return A Shiny UI element
climate_ui <- function(id) {
  ns <- NS(id)

  bslib::layout_column_wrap(
    width = 1,
    # bslib::layout_sidebar(
    # Sidebar for controls
    # sidebar = bslib::sidebar(
    #   title = "Analysis Controls",
    #   width = 300,

    #   selectInput(
    #     ns("climate_factor"),
    #     "Climate Factor:",
    #     choices = c(
    #       "Average Temperature" = "temp",
    #       "Precipitation" = "precip",
    #       "Humidity" = "humidity",
    #       "Growing Season Length" = "season"
    #     ),
    #     selected = "temp"
    #   ),

    #   selectInput(
    #     ns("social_factor"),
    #     "Social Factor:",
    #     choices = c(
    #       "Population Density" = "pop_density",
    #       "Outdoor Recreation" = "recreation",
    #       "Forest Coverage" = "forest",
    #       "Urban Sprawl" = "sprawl"
    #     ),
    #     selected = "pop_density"
    #   ),

    #   sliderInput(
    #     ns("year_range"),
    #     "Year Range:",
    #     min = 2000,
    #     max = 2023,
    #     value = c(2010, 2023),
    #     step = 1,
    #     sep = ""
    #   ),

    #   hr(),

    #   h6("Key Climate Drivers:", class = "fw-bold"),
    #   tags$ul(
    #     class = "small",
    #     tags$li("Rising temperatures"),
    #     tags$li("Longer warm seasons"),
    #     tags$li("Changing precipitation patterns"),
    #     tags$li("Milder winters")
    #   )
    # ),

    # Main content area
    bslib::layout_column_wrap(
      width = 1,

      # Page header
      bslib::card(
        bslib::card_body(
          class = "p-4 text-center bg-light",
          h2("Climate & Enviromental Risk Factors", class = "mb-3"),
          h4(
            "Understanding how climate and environmental changes are expanding the population of people at risk for Lyme disease",
            class = "text-muted fw-normal mb-0"
          )
        ),
        bslib::card_body(
          p(
            class = "lead text-center",
            style = "margin-top: 10px;",
            "A large expansion in the spatial distribution and concentration of Lyme disease cases is apparent from the data shown on the Geographic Distribution tab. Although case definitions have changed over time, that does not adequately explain the geographic expansion. There are several potential causes of this spread"
          )
        )
      ),

      # Climate impact explanation
      fluidRow(
        column(
          width = 3,
          bslib::card(
            class = "border-0 shadow-sm",
            bslib::card_body(
              class = "text-center",
              icon("temperature-high", class = "fa-3x text-danger mb-2"),
              h6("Warmer Annual Temperatures"),
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
                "Wetter conditions in the central and northeastern U.S create favorable tick habitats",
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
                "Increases tick survival rates through warmer winter months",
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
              h6("Outdoor Exposures"),
              p(
                "Likelihood of a tick encounter increases as Americans spend more time outdoors",
                class = "small mb-0"
              )
            )
          )
        )
      ),

      # Climate correlation chart
      bslib::layout_column_wrap(
        bslib::card(
          full_screen = TRUE,
          bslib::card_header(
            class = "bg-primary text-white",
            icon("snowflake"),
            "Milder Winters"
          ),
          fluidRow(
            column(
              width = 6,
              bslib::card_body(
                p(
                  "The major climate factor driving the increase of Lyme disease is the warming of wintertime temperatures. Deer ticks cannot survive over the winter when low temperatures are consistently colder than about 10°F. Historically, the northeastern United States regularly reached temperatures of that level, so tick populations were significantly reduced in most winters. Over the last few decades, rising wintertime temperatures now allow tick populations to survive."
                ),
                tags$br(),
                bslib::card(
                  class = "bg-light",
                  bslib::card_body(
                    class = "text-primary fw-bold",
                    p(
                      icon("exclamation-triangle"),
                      " These trends mean more people in more places are at risk for Lyme disease, underscoring the need for increased public health awareness and prevention."
                    )
                  )
                )
              )
            ),
            column(
              width = 6,
              bslib::card_body(
                img(
                  src = "images/winter-temps-1896-2020.gif", # replace with your actual image file name
                  alt = "Map showing milder winter temperatures"
                  # style = "max-width: 220px; margin-top: 0.5em; border-radius: 8px; box-shadow: 0 2px 6px #0001;"
                )
              )
            )
          ),
          card_footer(
            "Sources: ",
            popover(
              a(
                "NOAA NCEI (n.d.)",
                href = "javascript:void(0);"
              ),
              markdown(
                "National Oceanic and Atmospheric Administration: National Center for Environmental Information. (n.d.). *New 1991-2020 Normals*. [https://www.weather.gov/tbw/newnormals](https://www.weather.gov/tbw/newnormals)"
              )
            )
          )
        ),
        # bslib::card(
        #   full_screen = TRUE,
        #   bslib::card_header(
        #     class = "bg-primary text-white",
        #     icon("map-marked-alt"),
        #     "Maps"
        #   ),
        #   bslib::card_body(
        #     img(
        #       src = "images/winter-temps-1896-2020.gif", # replace with your actual image file name
        #       alt = "Map showing milder winter temperatures"
        #       # style = "max-width: 220px; margin-top: 0.5em; border-radius: 8px; box-shadow: 0 2px 6px #0001;"
        #     )
        #     # tags$div(
        #     #   style = "margin-bottom: 1em;",
        #     #   icon("location-dot", class = "text-success"),
        #     #   tags$b("Precipitation Changes:"),
        #     #   " In the eastern United States, black-legged ticks (sometimes called deer ticks) are the main species carrying the ",
        #     #   tags$em("Borrelia"),
        #     #   " bacteria, while along the West Coast of the United States, western black-legged ticks are the dominant species."
        #     # ),
        #     # tags$div(
        #     #   style = "margin-bottom: 1em;",
        #     #   icon("leaf", class = "text-warning"),
        #     #   tags$b("Outdoor Exposure:"),
        #     #   "Ticks are especially common in wooded areas and tall grasses. As Americans spend more time outdoors in nature and developments expand into previously rural areas, the likelihood of a tick encounter increases."
        #     # )
        #   ),
        #   card_footer(
        #     "Sources: ",
        #     popover(
        #       a("NOAA NCEI (n.d.)", href = "javascript:void(0);"),
        #       markdown(
        #         "National Oceanic and Atmospheric Administration: National Center for Environmental Information. (n.d.). *New 1991-2020 Normals*. [https://www.weather.gov/tbw/newnormals](https://www.weather.gov/tbw/newnormals)"
        #       )
        #     )
        #   )
        # )
      ),

      # Social factors chart
      # bslib::card(
      #   full_screen = TRUE,
      #   bslib::card_header("Social & Environmental Risk Factors"),
      #   bslib::card_body(
      #     echarts4r::echarts4rOutput(ns("social_factors"), height = "400px")
      #   )
      # ),

      # At-risk population analysis
      # bslib::layout_column_wrap(
      #   width = 1 / 2,

      #   bslib::card(
      #     bslib::card_header("Expanding At-Risk Population"),
      #     bslib::card_body(
      #       h5("Population Groups at Increased Risk:", class = "mb-3"),
      #       bslib::card(
      #         class = "border-start border-warning border-4 mb-2",
      #         bslib::card_body(
      #           class = "py-2",
      #           h6("Outdoor Workers", class = "mb-1"),
      #           p(
      #             "Landscapers, foresters, and agricultural workers face daily exposure",
      #             class = "small mb-0"
      #           )
      #         )
      #       ),
      #       bslib::card(
      #         class = "border-start border-warning border-4 mb-2",
      #         bslib::card_body(
      #           class = "py-2",
      #           h6("Suburban Residents", class = "mb-1"),
      #           p(
      #             "Urban sprawl brings more people into tick habitats",
      #             class = "small mb-0"
      #           )
      #         )
      #       ),
      #       bslib::card(
      #         class = "border-start border-warning border-4 mb-2",
      #         bslib::card_body(
      #           class = "py-2",
      #           h6("Outdoor Enthusiasts", class = "mb-1"),
      #           p(
      #             "Hikers, campers, and hunters in endemic areas",
      #             class = "small mb-0"
      #           )
      #         )
      #       ),
      #       bslib::card(
      #         class = "border-start border-warning border-4 mb-2",
      #         bslib::card_body(
      #           class = "py-2",
      #           h6("Children", class = "mb-1"),
      #           p(
      #             "More time playing outdoors, less aware of tick prevention",
      #             class = "small mb-0"
      #           )
      #         )
      #       )
      #     )
      #   ),

      #   bslib::card(
      #     bslib::card_header("Climate-Driven Expansion"),
      #     bslib::card_body(
      #       bslib::value_box(
      #         title = "Temperature Increase",
      #         value = "+2.5°F",
      #         showcase = icon("temperature-arrow-up"),
      #         theme = "danger",
      #         p("Average warming since 1970 in Northeast", class = "fs-6")
      #       ),
      #       bslib::value_box(
      #         title = "Growing Season",
      #         value = "+2 weeks",
      #         showcase = icon("calendar-plus"),
      #         theme = "warning",
      #         p("Longer period for tick activity", class = "fs-6")
      #       ),
      #       bslib::value_box(
      #         title = "Geographic Shift",
      #         value = "150mi North",
      #         showcase = icon("arrow-up"),
      #         theme = "info",
      #         p("Northward tick range expansion", class = "fs-6")
      #       )
      #     )
      #   )
      # )
    )
  )
}
