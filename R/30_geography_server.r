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

    # US Map
    output$us_map <- renderHighchart({
      ns <- session$ns

      # Prepare data for map - echarts4r expects lowercase state names
      # map_data <- data |>
      #   dplyr::select(name = state, value) |>
      #   dplyr::mutate(name = tolower(name))

      # highchart() %>%
      #   hc_title(text = "Test") %>%
      #   hc_add_series_map(
      #     map = "countries/us/us-all-all"
      #     # df = map_data,
      #     # joinBy =
      #   )

      # hcmap("countries/us/us-all-all")

      tooltip_header <- if (input$geo_level == "State") {
        "return ('<b>State</b>: ' + this.point.stname +"
      } else if (input$geo_level == "County") {
        "return ('<b>County</b>: ' + this.point.ctyname +"
      }

      # Create the county map
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

      # # Determine which map to use and filter map_data
      # if (input$geography == "United States") {
      #   map_name <- "countries/us/us-all-all"
      #   map_df <- map_data()
      #   data_df <- map_data()
      # } else {
      #   # Filter map_data to only counties in the selected state
      #   map_name <- "countries/us/us-all-all"
      #   state_fips <- lyme_cases %>%
      #     filter(stname == input$geography) %>%
      #     distinct(stcode) %>%
      #     pull(stcode) %>%
      #     sprintf("%02d", .)
      #   map_df <- map_data() %>%
      #     filter(substr(fips, 1, 2) == state_fips)
      #   data_df <- map_data() %>%
      #     filter(substr(fips, 1, 2) == state_fips)
      # }

      # hcmap(
      #   map = map_name,
      #   data = data_df,
      #   value = "cases",
      #   joinBy = c("fips", "fips"),
      #   name = "Lyme Disease Cases",
      #   borderColor = "#FAFAFA",
      #   borderWidth = 0.5,
      #   tooltip = list(
      #     formatter = JS(
      #       "function() {
      #     return this.point.ctyname + ': <b>' +
      #       Highcharts.numberFormat(this.point.cases, 0, '.', ',') + '</b>';
      #   }"
      #     )
      #   )
      # ) %>%
      #   hc_colorAxis(
      #     stops = list(
      #       list(0, "#a2bbbd"),
      #       list(0.5, "#FFA726"),
      #       list(1, "#254D56")
      #     )
      #   ) %>%
      #   hc_mapNavigation(enabled = TRUE)

      # hcmap(
      #   map = "countries/us/us-all-all", # US counties map
      #   data = map_data(),
      #   value = "rate",
      #   joinBy = c("fips", "GEOID"),
      #   name = "Lyme Disease",
      #   # dataLabels = list(enabled = FALSE),
      #   borderColor = "#FAFAFA",
      #   borderWidth = 0.5
      # ) %>%
      # hc_tooltip(
      #   # tooltip = list(
      #   formatter = JS(
      #     "function() {
      #   return '<b>' + this.point.ctyname + ': </b><br>' +
      #     Highcharts.numberFormat(this.point.cases, 0, '.', ',') + '</b>';
      #   }"
      #   )
      #   # format = "{point.value:,.0f}"
      #   # valueDecimals = 2,
      #   # valuePrefix = "",
      #   # valueSuffix = ""
      #   #)
      # ) %>%
      # hc_colorAxis(
      #   stops = list(
      #     list(0, "#E0E0E0"),
      #     list(0.001, "#a2bbbd"),
      #     list(1, "#254D56")
      #   )
      #   # minColor = "#a2bbbd",
      #   # maxColor = "#254D56"
      #   # stops = color_stops(n = 10)
      # ) %>%
      # # hc_title(text = "US County Map") %>%
      # # hc_subtitle(text = "Interactive county-level visualization") %>%
      # # hc_legend(
      # #   title = list(text = "Cases"),
      # #   layout = "vertical",
      # #   align = "right",
      # #   verticalAlign = "middle"
      # # ) %>%
      # hc_mapNavigation(enabled = TRUE)
    })

    # Trend chart
    # output$trend_chart <- echarts4r::renderEcharts4r({
    #   data <- time_series_data()

    #   data |>
    #     dplyr::group_by(state) |>
    #     echarts4r::e_charts(year) |>
    #     echarts4r::e_line(cases, smooth = TRUE) |>
    #     echarts4r::e_color(lyme_palette) |>
    #     echarts4r::e_title(
    #       text = "Lyme Disease Cases: Top 5 Endemic States",
    #       subtext = "2010-2023 trends"
    #     ) |>
    #     echarts4r::e_legend(
    #       type = "scroll",
    #       bottom = 0
    #     ) |>
    #     echarts4r::e_tooltip(trigger = "axis") |>
    #     echarts4r::e_x_axis(
    #       name = "Year",
    #       nameLocation = "middle",
    #       nameGap = 30
    #     ) |>
    #     echarts4r::e_y_axis(
    #       name = "Number of Cases",
    #       nameLocation = "middle",
    #       nameGap = 50
    #     ) |>
    #     echarts4r::e_datazoom(type = "slider") |>
    #     echarts4r::e_toolbox_feature(feature = "saveAsImage")
    # })

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
