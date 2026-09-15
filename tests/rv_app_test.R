# Exercise dashboard server logic under the rv environment
library(shiny)
library(highcharter)

source("global.r")
for (f in list.files("R", full.names = TRUE)) {
  source(f)
}

results <- list()

# renderHighchart outputs resolve to JSON payloads under testServer;
# a valid non-trivial payload means the widget rendered without error
rendered <- function(x) inherits(x, "json") && nchar(x) > 500

testServer(home_server, {
  # start_exploring click uses session$parent, which doesn't exist under testServer
  ts <- output$time_series
  results$home_time_series <<- rendered(ts)
  results$home_has_cases <<- grepl("Cases", ts)
})

testServer(geography_server, {
  # default view: US, county level
  session$setInputs(
    geography = "United States",
    geo_level = "County",
    year = 2022
  )
  m1 <- output$us_map
  results$geo_map_us_county <<- rendered(m1)
  results$geo_map_us_county_pts <<- nrow(map_data())

  # switch to state level
  session$setInputs(geo_level = "State", year = 2019)
  m2 <- output$us_map
  results$geo_map_us_state <<- rendered(m2)
  results$geo_map_us_state_rows <<- nrow(map_data())

  # drill into a single state at county level
  session$setInputs(
    geography = "Pennsylvania",
    geo_level = "County",
    year = 2022
  )
  m3 <- output$us_map
  results$geo_map_pa_county <<- rendered(m3)
  results$geo_map_pa_rows <<- nrow(map_data())
  results$geo_pa_title <<- grepl("2022", m3)

  # expansion chart (static, no inputs)
  results$geo_expansion <<- rendered(output$geo_expansion)
})

cat("---- RESULTS ----\n")
for (n in names(results)) {
  cat(sprintf("%-24s %s\n", n, results[[n]]))
}
cat(
  "ALL PASS:",
  all(unlist(results[c(
    "home_time_series",
    "home_has_cases",
    "geo_map_us_county",
    "geo_map_us_state",
    "geo_map_pa_county",
    "geo_pa_title",
    "geo_expansion"
  )])),
  "\n"
)
