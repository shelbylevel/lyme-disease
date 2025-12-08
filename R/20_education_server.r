# ==============================================================================
# LYME DISEASE 101 MODULE - SERVER
# ==============================================================================

#' Lyme Disease Education Module Server
#'
#' @param id Module namespace ID
#'
#' @return Reactive values from the module
education_server <- function(id) {
  moduleServer(id, function(input, output, session) {
    ns <- session$ns

    # ------ REACTIVE ----------------------------------------------------------

    cases <- reactive({
      lyme_data %>%
        group_by(year) %>%
        summarize(total_cases = sum(cases, na.rm = TRUE))
    })

    rates <- reactive({
      lyme_data %>%
        left_join(pop_est, by = c("GEOID", "year")) %>%
        mutate(rate = (cases / pop) * 100000) %>%
        group_by(year) %>%
        summarize(avg_rate = mean(rate, na.rm = TRUE))
    })

    # ------ OUTPUT ------------------------------------------------------------

    # output$time_series <- renderHighchart({
    #   highchart() %>%
    #     hc_add_series(
    #       data = plot_data(),
    #       type = "line",
    #       hcaes(x = year, y = total_cases),
    #       name = "Total Lyme Disease Cases"
    #     ) %>%
    #     hc_yAxis(title = list(text = "Total Cases")) %>%
    #     hc_xAxis(title = list(text = "Year")) %>%
    #     hc_title(text = "Lyme Disease Cases Over Time") %>%
    #     hc_chart(style = list(fontFamily = "Georgia")) %>%
    #     hc_size(height = 600)
    # })

    # highchart() %>%
    #   # Data
    #   hc_add_series(
    #     us_time,
    #     "column",
    #     hcaes(
    #       x = Year.Code,
    #       y = RATE
    #     ),
    #     name = "Death Rate"
    #   ) %>%
    #   # Options for each type of series
    #   hc_plotOptions(
    #     series = list(
    #       showInLegend = FALSE,
    #       tooltip = list(valueDecimals = 1),
    #       color = '#6084A6'
    #     )
    #   ) %>%
    #   # Axis
    #   hc_yAxis(
    #     title = list(text = "Rate per 100,000 population")
    #   ) %>%
    #   # Titles, subtitle, caption and credits
    #   #hc_title(
    #   #text = "Firearm Deaths (All Intent) by Year, 1999-2022"
    #   #) %>%
    #   #hc_caption(
    #   #text = "Death rates per 100,000 population"
    #   #) %>%
    #   hc_chart(
    #     style = list(fontFamily = "Georgia")
    #   ) %>%
    #   hc_size(
    #     height = 600
    #   )

    # ------ RETURN VALUES -----------------------------------------------------
    return(NULL)
  })
}
