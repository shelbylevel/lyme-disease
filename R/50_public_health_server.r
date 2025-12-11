# ==============================================================================
# PUBLIC HEALTH IMPACT MODULE - SERVER
# ==============================================================================

#' Public Health Impact Module Server
#'
#' @param id Module namespace ID
#'
#' @return Reactive values from the module
public_health_server <- function(id) {
  moduleServer(id, function(input, output, session) {
    ns <- session$ns

    # ------ REACTIVE DATA -----------------------------------------------------

    # # Generate healthcare burden data by region
    # burden_data <- reactive({
    #   regions <- c(
    #     "Northeast",
    #     "Mid-Atlantic",
    #     "Upper Midwest",
    #     "Southeast",
    #     "Southwest",
    #     "West",
    #     "Northwest"
    #   )

    #   data.frame(
    #     region = regions,
    #     cases = c(150000, 180000, 95000, 25000, 8000, 12000, 15000),
    #     cost_millions = c(450, 540, 285, 75, 24, 36, 45),
    #     physicians_trained = c(85, 78, 65, 35, 15, 20, 25)
    #   ) |>
    #     dplyr::arrange(desc(cases))
    # })

    # ------ OUTPUT ------------------------------------------------------------

    # Healthcare burden chart
    # output$burden_chart <- echarts4r::renderEcharts4r({
    #   data <- burden_data()

    #   data |>
    #     echarts4r::e_charts(region) |>
    #     echarts4r::e_bar(
    #       cases,
    #       name = "Annual Cases",
    #       y_index = 0
    #     ) |>
    #     echarts4r::e_bar(
    #       cost_millions,
    #       name = "Healthcare Costs ($M)",
    #       y_index = 1
    #     ) |>
    #     echarts4r::e_color(lyme_palette[c(1, 5)]) |>
    #     echarts4r::e_title(
    #       text = "Regional Healthcare Burden",
    #       subtext = "Cases and costs by US region"
    #     ) |>
    #     echarts4r::e_legend(bottom = 0) |>
    #     echarts4r::e_tooltip(trigger = "axis") |>
    #     echarts4r::e_y_axis(
    #       index = 0,
    #       name = "Number of Cases",
    #       nameLocation = "middle",
    #       nameGap = 50
    #     ) |>
    #     echarts4r::e_y_axis(
    #       index = 1,
    #       name = "Healthcare Costs ($M)",
    #       nameLocation = "middle",
    #       nameGap = 50,
    #       position = "right"
    #     ) |>
    #     echarts4r::e_x_axis(
    #       axisLabel = list(interval = 0, rotate = 30)
    #     ) |>
    #     echarts4r::e_toolbox_feature(feature = "saveAsImage") |>
    #     echarts4r::e_grid(bottom = "20%")
    # })

    # ------ RETURN VALUES -----------------------------------------------------
  })
}
