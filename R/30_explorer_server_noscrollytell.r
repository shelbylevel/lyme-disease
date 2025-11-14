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
    
    # Generate sample Lyme disease data by state
    state_data <- reactive({
      # High-risk endemic states
      endemic_states <- c("Connecticut", "Delaware", "Maine", "Maryland", 
                         "Massachusetts", "Minnesota", "New Hampshire", 
                         "New Jersey", "New York", "Pennsylvania", 
                         "Rhode Island", "Vermont", "Virginia", "Wisconsin")
      
      # Create data frame
      states <- state.name
      data.frame(
        state = states,
        year = input$year,
        # Simulate higher rates in endemic states
        rate = ifelse(
          states %in% endemic_states,
          runif(length(states), 30, 120),  # High endemic
          runif(length(states), 0, 15)     # Low/emerging
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
          value = switch(input$metric,
            "total_cases" = total_cases,
            "rate" = rate,
            "change" = change,
            rate
          )
        )
    })
    
    # Generate time series data
    time_series_data <- reactive({
      years <- 2010:2023
      
      # Top 5 endemic states
      top_states <- c("Pennsylvania", "New York", "New Jersey", 
                     "Connecticut", "Massachusetts")
      
      # Create data for each state
      do.call(rbind, lapply(top_states, function(st) {
        base_cases <- switch(st,
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
          cases = base_cases * (1 + seq(0, 0.3, length.out = length(years))) +
                  rnorm(length(years), 0, 500)
        )
      }))
    })
    
    # ------ OUTPUT ------------------------------------------------------------
    
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
          text = c("High", "Low")
        ) |>
        echarts4r::e_title(
          text = paste("Lyme Disease -", input$year),
          subtext = switch(input$metric,
            "total_cases" = "Total reported cases",
            "rate" = "Cases per 100,000 population",
            "change" = "Year-over-year % change",
            ""
          )
        ) |>
        echarts4r::e_tooltip(
          trigger = "item",
          formatter = htmlwidgets::JS("
            function(params) {
              return params.name + '<br/>' + 
                     'Value: ' + params.value.toFixed(1);
            }
          ")
        ) |>
        echarts4r::e_toolbox_feature(feature = "saveAsImage")
    })
    
    # Trend chart
    output$trend_chart <- echarts4r::renderEcharts4r({
      data <- time_series_data()
      
      data |>
        dplyr::group_by(state) |>
        echarts4r::e_charts(year) |>
        echarts4r::e_line(cases, smooth = TRUE) |>
        echarts4r::e_color(lyme_palette) |>
        echarts4r::e_title(
          text = "Lyme Disease Cases: Top 5 Endemic States",
          subtext = "2010-2023 trends"
        ) |>
        echarts4r::e_legend(
          type = "scroll",
          bottom = 0
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
        echarts4r::e_datazoom(type = "slider") |>
        echarts4r::e_toolbox_feature(feature = "saveAsImage")
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
    
    return(list(
      state_data = state_data,
      time_series = time_series_data
    ))
  })
}
