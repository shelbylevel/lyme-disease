# ==============================================================================
# GEOGRAPHIC DISTRIBUTION MODULE - SERVER
# ==============================================================================

#' Geographic Distribution Module Server
#'
#' @param id Module namespace ID
#'
#' @return Reactive values from the module
geography_server <- function(id) {
  moduleServer(id, function(input, output, session) {
    ns <- session$ns

    # ------ REACTIVE DATA -----------------------------------------------------

    map_data <- reactive({
      if (input$geography == "United States") {
        filtered_data <- lyme_data
      } else {
        filtered_data <- lyme_data %>%
          filter(stname == input$geography)
      }

      if (input$geo_level == "County") {
        filtered_data <- filtered_data %>%
          filter(nchar(GEOID) == 5)
      } else if (input$geo_level == "State") {
        filtered_data <- filtered_data %>%
          filter(nchar(GEOID) == 2)
      }

      filtered_data %>%
        filter(year == input$year) %>%
        mutate(cases = as.numeric(cases))
    })

    map_geom <- reactive({
      if (input$geo_level == "State") {
        if (input$geography != "United States") {
          geom <- state_geom %>%
            filter(NAME == input$geography)
        } else {
          geom <- state_geom
        }
      } else if (input$geo_level == "County") {
        if (input$geography != "United States") {
          geom <- cty_geom %>%
            filter(STATE_NAME == input$geography)
        } else {
          geom <- cty_geom
        }
      }

      # convert to list for highcharter
      geom %>%
        geojsonio::geojson_list()
    })

    # ------ OUTPUT ------------------------------------------------------------

    # Map
    output$us_map <- renderHighchart({
      ns <- session$ns

      tooltip_header <- if (input$geo_level == "State") {
        "return ('<b>State</b>: ' + this.point.stname +"
      } else if (input$geo_level == "County") {
        "return ('<b>County</b>: ' + this.point.ctyname +"
      }

      # Create map
      highchart() %>%
        hc_add_series_map(
          map = map_geom(),
          df = map_data(),
          value = "rate",
          joinBy = "GEOID",
          name = "Lyme Disease"
        ) %>%
        hc_title(text = paste("Lyme Disease Cases in", input$year)) %>%
        hc_mapNavigation(enabled = TRUE) %>%
        hc_tooltip(
          formatter = JS(
            paste0(
              "function(){",
              tooltip_header,
              "' <br> <b>Rate</b>: ' + Highcharts.numberFormat(this.point.value, 2, '.', ',') +
                ' <br> <b>Cases</b>: ' + Highcharts.numberFormat(this.point.cases, 0, '.', ','));
              }"
            )
          )
        ) %>%
        hc_legend(
          title = list(text = "Case Rate (per 100,000 population)")
        ) %>%
        hc_colorAxis(
          stops = list(
            list(0, "#E0E0E0"),
            list(0.001, "#a2bbbd"),
            list(1, "#254D56")
          )
          # minColor = "#a2bbbd",
          # maxColor = "#254D56"
          # stops = color_stops(n = 10)
        )
      # hc_colorAxis(
      #   minColor = "#E7ECC3",
      #   maxColor = "#005C44"
      # ) %>%
      #hc_size(height = 600, width = 600)
    })

    # Trend chart
    output$geo_expansion <- renderHighchart({
      ns <- session$ns

      highchart() %>%
        hc_xAxis(
          categories = cty_expansion$year,
          title = list(text = "Year")
        ) %>%
        hc_yAxis_multiples(
          list(
            title = list(text = "Counties with Lyme Disease Cases"),
            opposite = FALSE
          ),
          list(
            title = list(text = "Percent Change Since 2001"),
            opposite = TRUE
          )
        ) %>%
        hc_add_series(
          name = "Counties with Cases",
          type = "column",
          data = cty_expansion$ctys_w_cases,
          yAxis = 0,
          color = "#45767a"
        ) %>%
        hc_add_series(
          name = "Percent Change Since 2001",
          type = "line",
          data = cty_expansion$pct_change_since_2001,
          yAxis = 1,
          color = "#FFA726",
          tooltip = list(valueDecimals = 1, valueSuffix = "%")
        ) %>%
        hc_title(
          text = "Geographic Expansion of Lyme Disease Across US Counties"
        ) %>%
        hc_tooltip(
          shared = TRUE,
          formatter = JS(
            "function() {
            var s = '<b>' + this.x + '</b>';
            this.points.forEach(function(pt) {
              var val = pt.series.name === 'Counties with Cases'
                ? Highcharts.numberFormat(pt.y, 0, '.', ',')
                : Highcharts.numberFormat(pt.y, 1, '.', ',') + '%';
              s += '<br/><span style=\"color:' + pt.color + '\">\u25CF</span> <b>' +
                pt.series.name + '</b>: ' + val;
              });
              return s;
            }"
          )
        )
    })

    # ------ OBSERVERS ---------------------------------------------------------

    # Play animation button
    observeEvent(input$play_animation, {
      showNotification(
        "Time animation feature - would cycle through years automatically",
        type = "message",
        duration = 3
      )
    })

    # ------ RETURN VALUES -----------------------------------------------------

    # return(list(
    #   # state_data = state_data,
    #   time_series = time_series_data
    # ))
  })
}
