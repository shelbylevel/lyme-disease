# ==============================================================================
# GLOBAL.R - App Initialization
# ==============================================================================
# Lyme Disease and Climate Change Dashboard
# This file contains everything that needs to be initialized when the app starts

# ------ Load Packages ---------------------------------------------------------
library(shiny)
library(bslib)
library(data.table)
library(echarts4r)
library(echarts4r.maps)
library(highcharter)
library(dplyr)
library(sf) # For spatial data
library(tigris) # For US state boundaries
library(scrollytell) # For scrollytelling features

# ------ Set R Options ---------------------------------------------------------
options(
  scipen = 1000, # Disable scientific notation
  tigris_use_cache = TRUE
)

# ------ Global Variables ------------------------------------------------------
# Define constants used throughout the app
current_year <- as.numeric(format(Sys.Date(), "%Y"))

# Lyme disease color palette (greens and earth tones)
lyme_palette <- c(
  "#2E7D32", # Dark green (primary)
  "#66BB6A", # Medium green
  "#A5D6A7", # Light green
  "#8D6E63", # Brown (ticks)
  "#FFA726", # Orange (warning)
  "#EF5350", # Red (high risk)
  "#42A5F5", # Blue (water/climate)
  "#7E57C2" # Purple (accent)
)

# ------ Load Data -------------------------------------------------------------
# In production, load actual Lyme disease data here
# Example data structure you might use:
map_data <- get_data_from_map(download_map_data("countries/us/us-all-all"))

# map_data <- tigris::counties(
#   cb = TRUE, #clip boundaries
#   year = 2020
# ) %>%
#   select(STATEFP, COUNTYFP, GEOID)

lyme_cases <- fread("data/ld-case-counts-cty-2001-2023.csv") %>%
  janitor::clean_names() %>%
  tidyr::pivot_longer(
    cols = starts_with("cases"),
    names_to = "year",
    names_prefix = "cases",
    values_to = "cases"
  ) %>%
  mutate(
    ctyname = stringr::str_remove(ctyname, " County"),
    fips = sprintf("%02d%03d", stcode, ctycode)
  )

available_years <- lyme_cases %>%
  distinct(year) %>%
  pull(year) %>%
  as.numeric()

available_geos <- c(
  "United States",
  lyme_cases %>%
    distinct(stname) %>%
    pull(stname)
)

# climate_data <- fread("data/climate_factors.csv")
# tick_habitat <- fread("data/tick_habitat_suitability.csv")

# For now, we'll create sample data in the modules
# When you have real data, load it here so it's available to all users
