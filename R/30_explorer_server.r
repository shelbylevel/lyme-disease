# ==============================================================================
# GEOGRAPHIC DISTRIBUTION MODULE - SERVER (with Scrollytelling)
# ==============================================================================

#' Geographic Distribution Module Server
#'
#' @param id Module namespace ID
#'
#' @return Reactive values from the module
geography_server <- function(id) {
  moduleServer(id, function(input, output, session) {
    ns <- session$ns

    # ------ SCROLLYTELL RENDERER ----------------------------------------------

    scrollytell::render_scrollytell(
      outputId = "scr",

      # Track which section is active
      active_section = reactive({
        input$scr
      })
    )

    # ------ REACTIVE DATA -----------------------------------------------------

    # Use year from scrollytell input if available, otherwise default
    selected_year <- reactive({
      if (!is.null(input$year_scrolly)) {
        input$year_scrolly
      } else {
        2023
      }
    })

    # Generate sample Lyme disease data by state
    state_data <- reactive({
      # High-risk endemic states
      endemic_states <- c(
        "Delaware",
        "Maine",
        "Maryland",
        "Massachusetts",
        "Minnesota",
        "New Hampshire",
        "New Jersey",
        "New York",
        "Pennsylvania",
        "Rhode Island",
        "Vermont",
        "Virginia",
        "Wisconsin"
      )

      # Create data frame
      states <- state.name
      data.frame(
        state = states,
        year = selected_year(),
        # Simulate higher rates in endemic states
        rate = ifelse(
          states %in% endemic_states,
          runif(length(states), 30, 120), # High endemic
          runif(length(states), 0, 15) # Low/emerging
        ),
        # Add some variation over years
        total_cases = ifelse(
          states %in% endemic_states,
          round(runif(length(states), 3000, 15000)),
          round(runif(length(states), 0, 500))
        )
      ) |>
        dplyr::mutate(
          change = rnorm(length(states), mean = 5, sd = 10),
          value = rate
        )
    })

    # Generate time series data
    time_series_data <- reactive({
      years <- 2010:2023

      # Top 5 endemic states
      top_states <- c(
        "Pennsylvania",
        "New York",
        "New Jersey",
        "Connecticut",
        "Massachusetts"
      )

      # Create data for each state
      do.call(
        rbind,
        lapply(top_states, function(st) {
          base_cases <- switch(
            st,
            "Pennsylvania" = 8000,
            "New York" = 7000,
            "New Jersey" = 5000,
            "Connecticut" = 4000,
            "Massachusetts" = 3500,
            3000
          )

          data.frame(
            year = years,
            state = st,
            cases = base_cases *
              (1 + seq(0, 0.3, length.out = length(years))) +
              rnorm(length(years), 0, 500)
          )
        })
      )
    })

    # ------ DYNAMIC OUTPUT BASED ON SCROLL SECTION ----------------------------

    output$map_output <- renderUI({
      section <- input$scr

      if (is.null(section) || section == "section1" || section == "section2") {
        # Show US map for sections 1-2
        tagList(
          h4("US Lyme Disease Distribution", class = "text-center mb-3"),
          echarts4r::echarts4rOutput(ns("us_map"), height = "600px")
        )
      } else if (section == "section3") {
        # Show trend chart for section 3
        tagList(
          h4("Cases Over Time: Top 5 States", class = "text-center mb-3"),
          echarts4r::echarts4rOutput(ns("trend_chart"), height = "600px")
        )
      } else if (section == "section4") {
        # Show regional breakdown for section 4
        tagList(
          h4("Regional Case Distribution", class = "text-center mb-3"),
          echarts4r::echarts4rOutput(ns("regional_chart"), height = "600px")
        )
      } else {
        # Show summary visualization for section 5
        tagList(
          h4("Projected Expansion Risk", class = "text-center mb-3"),
          echarts4r::echarts4rOutput(ns("us_map"), height = "600px"),
          p(
            class = "text-center text-muted mt-3",
            "Areas in darker green show higher current risk. Climate change is expected 
            to expand suitable habitat further north and west."
          )
        )
      }
    })

    # ------ CHART OUTPUTS -----------------------------------------------------

    # US Map
    output$us_map <- echarts4r::renderEcharts4r({
      data <- state_data()

      # Prepare data for map - echarts4r expects lowercase state names
      map_data <- data |>
        dplyr::select(name = state, value) |>
        dplyr::mutate(name = tolower(name))

      # Create map using built-in USA map
      map_data |>
        echarts4r::e_charts(name) |>
        echarts4r::e_map(value, map = "USA") |>
        echarts4r::e_visual_map(
          value,
          inRange = list(
            color = c("#E8F5E9", "#66BB6A", "#2E7D32", "#1B5E20")
          ),
          text = c("High", "Low"),
          bottom = "10%"
        ) |>
        echarts4r::e_title(
          text = paste("Lyme Disease Cases -", selected_year()),
          subtext = "Cases per 100,000 population",
          left = "center"
        ) |>
        echarts4r::e_tooltip(
          trigger = "item",
          formatter = htmlwidgets::JS(
            "
            function(params) {
              return params.name + '<br/>' + 
                     'Rate: ' + params.value.toFixed(1) + ' per 100K';
            }
          "
          )
        ) |>
        echarts4r::e_toolbox_feature(feature = "saveAsImage")
    })

    # Trend chart
    output$trend_chart <- echarts4r::renderEcharts4r({
      data <- time_series_data()

      data |>
        dplyr::group_by(state) |>
        echarts4r::e_charts(year) |>
        echarts4r::e_line(cases, smooth = TRUE, symbolSize = 8) |>
        echarts4r::e_color(lyme_palette) |>
        echarts4r::e_title(
          text = "Lyme Disease Cases: Top 5 Endemic States",
          subtext = "2010-2023 trends",
          left = "center"
        ) |>
        echarts4r::e_legend(
          type = "scroll",
          bottom = "5%"
        ) |>
        echarts4r::e_tooltip(trigger = "axis") |>
        echarts4r::e_x_axis(
          name = "Year",
          nameLocation = "middle",
          nameGap = 30
        ) |>
        echarts4r::e_y_axis(
          name = "Number of Cases",
          nameLocation = "middle",
          nameGap = 50
        ) |>
        echarts4r::e_datazoom(
          type = "slider",
          start = 0,
          end = 100
        ) |>
        echarts4r::e_toolbox_feature(feature = "saveAsImage")
    })

    # Regional chart
    output$regional_chart <- echarts4r::renderEcharts4r({
      regions <- data.frame(
        region = c(
          "Northeast",
          "Mid-Atlantic",
          "Upper Midwest",
          "Southeast",
          "West"
        ),
        cases = c(180000, 150000, 95000, 25000, 12000),
        growth = c(15, 18, 45, 35, 60)
      )

      regions |>
        echarts4r::e_charts(region) |>
        echarts4r::e_bar(cases, name = "Current Cases", y_index = 0) |>
        echarts4r::e_line(
          growth,
          name = "% Growth (10yr)",
          y_index = 1,
          symbolSize = 10
        ) |>
        echarts4r::e_color(lyme_palette[c(1, 5)]) |>
        echarts4r::e_title(
          text = "Regional Case Distribution & Growth",
          left = "center"
        ) |>
        echarts4r::e_legend(bottom = "5%") |>
        echarts4r::e_tooltip(trigger = "axis") |>
        echarts4r::e_y_axis(
          index = 0,
          name = "Cases",
          nameLocation = "middle",
          nameGap = 50
        ) |>
        echarts4r::e_y_axis(
          index = 1,
          name = "Growth %",
          nameLocation = "middle",
          nameGap = 50,
          position = "right"
        ) |>
        echarts4r::e_toolbox_feature(feature = "saveAsImage")
    })

    # ------ OBSERVERS ---------------------------------------------------------

    # Navigate to Climate tab when button clicked
    observeEvent(input$explore_climate, {
      updateNavbarPage(
        session = session$parent,
        inputId = "main_nav",
        selected = "Climate & Risk Factors"
      )
    })

    # ------ RETURN VALUES -----------------------------------------------------

    return(list(
      state_data = state_data,
      time_series = time_series_data
    ))
  })
}
