# ==============================================================================
# HOME/OVERVIEW MODULE - SERVER
# ==============================================================================

#' Overview Module Server
#'
#' @param id Module namespace ID
#'
#' @return Reactive values from the module
home_server <- function(id) {
  moduleServer(id, function(input, output, session) {
    ns <- session$ns

    # ------ OBSERVERS ---------------------------------------------------------

    # Navigate to Lyme Disease 101 tab when button clicked
    observeEvent(input$start_exploring, {
      updateNavbarPage(
        session = session$parent,
        inputId = "main_nav",
        selected = "Lyme Disease 101"
      )
    })

    # ------ OUTPUT ------------------------------------------------------------

    # Time series chart of Lyme disease cases and incidence rate
    output$time_series <- renderHighchart({
      highchart() %>%
        hc_xAxis(categories = lyme_yearly$year, title = list(text = "Year")) %>%
        hc_yAxis_multiples(
          list(title = list(text = "Cases"), opposite = FALSE),
          list(
            title = list(text = "Incidence Rate (per 100,000 population)"),
            opposite = TRUE
          )
        ) %>%
        hc_add_series(
          name = "Cases",
          type = "column",
          data = lyme_yearly$cases,
          yAxis = 0,
          color = "#45767a"
        ) %>%
        hc_add_series(
          name = "Incidence Rate",
          type = "line",
          data = lyme_yearly$rate,
          yAxis = 1,
          color = "#6f4a64"
        ) %>%
        hc_title(text = "Lyme Disease Cases and Incidence Rate by Year") %>%
        hc_tooltip(
          shared = TRUE,
          formatter = JS(
            "function() {
              var s = '<b>' + this.x + '</b>';
              this.points.forEach(function(pt) {
                var val = pt.series.name === 'Cases'
                  ? Highcharts.numberFormat(pt.y, 0, '.', ',')
                  : Highcharts.numberFormat(pt.y, 2, '.', ',');
                s += '<br/><span style=\"color:' + pt.color + '\">\u25CF</span> ' +
              '<b>' + pt.series.name + '</b>: ' + val;
            });
            return s;
          }"
          )
        )
    })
  })
}
