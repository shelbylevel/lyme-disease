# ==============================================================================
# CLIMATE & ENVIRONMENTAL RISK FACTORS MODULE - SERVER
# ==============================================================================

#' Climate Module Server
#'
#' @param id Module namespace ID
#'
#' @return Reactive values from the module
climate_server <- function(id) {
  moduleServer(id, function(input, output, session) {
    ns <- session$ns

    # ------ REACTIVE DATA -----------------------------------------------------

    # Generate climate correlation data
    climate_data <- reactive({
      years <- seq(input$year_range[1], input$year_range[2])

      # Simulate correlation between climate factor and Lyme cases
      base_cases <- 35000
      climate_trend <- seq(0, 1, length.out = length(years))

      data.frame(
        year = years,
        cases = base_cases *
          (1 + climate_trend * 0.5) +
          rnorm(length(years), 0, 2000),
        temp = 50 + climate_trend * 3 + rnorm(length(years), 0, 1),
        precip = 40 + climate_trend * 2 + rnorm(length(years), 0, 3),
        humidity = 65 + climate_trend * 1.5 + rnorm(length(years), 0, 2),
        season = 180 + climate_trend * 14 + rnorm(length(years), 0, 5)
      ) |>
        dplyr::mutate(
          climate_value = switch(
            input$climate_factor,
            "temp" = temp,
            "precip" = precip,
            "humidity" = humidity,
            "season" = season,
            temp
          )
        )
    })

    # Generate social factors data
    social_data <- reactive({
      factors <- c(
        "Population Density",
        "Outdoor Recreation",
        "Forest Coverage",
        "Urban Sprawl",
        "Pet Ownership"
      )

      data.frame(
        factor = factors,
        correlation = c(0.72, 0.65, 0.58, 0.68, 0.45),
        at_risk_pop = c(45, 38, 32, 41, 28) * 1000
      ) |>
        dplyr::arrange(desc(correlation))
    })

    # ------ OUTPUT ------------------------------------------------------------

    # Climate correlation scatter plot
    output$climate_correlation <- echarts4r::renderEcharts4r({
      data <- climate_data()

      # Get climate factor name
      factor_name <- switch(
        input$climate_factor,
        "temp" = "Average Temperature (°F)",
        "precip" = "Annual Precipitation (inches)",
        "humidity" = "Relative Humidity (%)",
        "season" = "Growing Season Length (days)",
        "Temperature"
      )

      data |>
        echarts4r::e_charts(climate_value) |>
        echarts4r::e_scatter(
          cases,
          symbol_size = 15,
          name = "Annual Cases"
        ) |>
        echarts4r::e_lm(
          cases ~ climate_value,
          name = "Trend Line"
        ) |>
        echarts4r::e_color(lyme_palette[c(1, 5)]) |>
        echarts4r::e_title(
          text = paste("Lyme Disease Cases vs.", factor_name),
          subtext = sprintf(
            "Years %d-%d",
            input$year_range[1],
            input$year_range[2]
          )
        ) |>
        echarts4r::e_x_axis(
          name = factor_name,
          nameLocation = "middle",
          nameGap = 30
        ) |>
        echarts4r::e_y_axis(
          name = "Number of Cases",
          nameLocation = "middle",
          nameGap = 50
        ) |>
        echarts4r::e_tooltip(
          trigger = "item",
          formatter = htmlwidgets::JS(
            "
            function(params) {
              if (params.seriesName === 'Annual Cases') {
                return 'Cases: ' + params.value[1].toFixed(0) + '<br/>' +
                       'Climate: ' + params.value[0].toFixed(1);
              }
            }
          "
          )
        ) |>
        echarts4r::e_legend(bottom = 0) |>
        echarts4r::e_toolbox_feature(feature = "saveAsImage")
    })

    # Social factors bar chart
    output$social_factors <- echarts4r::renderEcharts4r({
      data <- social_data()

      data |>
        echarts4r::e_charts(factor) |>
        echarts4r::e_bar(
          correlation,
          name = "Correlation with Lyme Cases"
        ) |>
        echarts4r::e_color(lyme_palette) |>
        echarts4r::e_title(
          text = "Social & Environmental Risk Factors",
          subtext = "Correlation strength with Lyme disease incidence"
        ) |>
        echarts4r::e_y_axis(
          name = "Correlation Coefficient",
          nameLocation = "middle",
          nameGap = 50,
          min = 0,
          max = 1
        ) |>
        echarts4r::e_x_axis(
          axisLabel = list(interval = 0, rotate = 30)
        ) |>
        echarts4r::e_tooltip(
          trigger = "axis",
          formatter = htmlwidgets::JS(
            "
            function(params) {
              return params[0].name + '<br/>' +
                     'Correlation: ' + params[0].value.toFixed(2);
            }
          "
          )
        ) |>
        echarts4r::e_legend(show = FALSE) |>
        echarts4r::e_toolbox_feature(feature = "saveAsImage") |>
        echarts4r::e_grid(bottom = "20%")
    })

    # ------ RETURN VALUES -----------------------------------------------------

    return(list(
      climate_data = climate_data,
      social_data = social_data
    ))
  })
}
