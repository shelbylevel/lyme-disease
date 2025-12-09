# ==============================================================================
# GLOBAL.R - App Initialization
# ==============================================================================
# Lyme Disease and Climate Change Dashboard
# This file contains everything that needs to be initialized when the app starts

# ------ Load Packages ---------------------------------------------------------
library(shiny)
library(bslib)
library(data.table)
library(highcharter)
library(tidyverse)

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
# map_data <- get_data_from_map(download_map_data("countries/us/us-all-all"))

# Load US county geometries for mapping
cty_geom <- tigris::counties(
  cb = TRUE, #clip boundaries
  year = 2020
) %>%
  tigris::shift_geometry() %>% # move AK and HI
  filter(as.numeric(STATEFP) < 57) # Keep only 50 states & DC

# Load US state geometries for mapping
state_geom <- tigris::states(
  cb = TRUE, #clip boundaries
  year = 2020
) %>%
  tigris::shift_geometry() %>% # move AK and HI
  filter(as.numeric(STATEFP) < 57) # Keep only 50 states & DC

# Load population estimates for rate calculations

# For 2001-2009: Download intercensal estimates directly
pop_2001_2009 <- fread("data/intercensal-pop-est-2000-2010.csv") %>%
  #   readr::read_csv(
  #   "https://www2.census.gov/programs-surveys/popest/datasets/2000-2010/intercensal/county/co-est00int-tot.csv"
  # ) %>%
  filter(SUMLEV %in% c("40", "50")) %>% # state & county level
  mutate(
    GEOID = if_else(
      SUMLEV == "40",
      str_pad(STATE, 2, pad = "0"), # state-level: two-digit STATE code
      paste0(
        str_pad(STATE, 2, pad = "0"),
        str_pad(COUNTY, 3, pad = "0")
      ) # county-level: two-digit STATE + three-digit COUNTY
    )
  ) %>%
  select(GEOID, POPESTIMATE2001:POPESTIMATE2009) %>%
  tidyr::pivot_longer(
    cols = starts_with("POPESTIMATE"),
    names_to = "year",
    values_to = "pop"
  ) %>%
  mutate(
    year = as.numeric(str_extract(year, "\\d{4}")),
  ) %>%
  select(GEOID, year, pop)

# For 2010-2019: Use tidycensus time series 2019 vintage estimates
# (to access Population Estimates Program (PEP) datasets)
pop_cty_2010_2019 <- tidycensus::get_estimates(
  geography = "county",
  product = "population",
  time_series = TRUE,
  vintage = 2019
)

pop_state_2010_2019 <- tidycensus::get_estimates(
  geography = "state",
  product = "population",
  time_series = TRUE,
  vintage = 2019
)

pop_2010_2019 <- bind_rows(pop_cty_2010_2019, pop_state_2010_2019) %>%
  filter(
    !DATE %in% c(1, 2), # exclude 2010 count & baseline
    variable == "POP"
  ) %>%
  mutate(year = DATE + 2007) %>% # DATE 3 = 2010, so add 2007
  select(GEOID, year, pop = value)

#alternative in case of Census error
# pop_2010_2019 <- censusapi::getCensus(
#   name = "pep/population",
#   vintage = 2019,
#   vars = c("POP", "DATE_CODE"),
#   region = "county:*"
# ) %>%
#   mutate(
#     GEOID = paste0(
#       str_pad(state, 2, pad = "0"),
#       str_pad(county, 3, pad = "0")
#     )
#   ) %>%
#   filter(!DATE_CODE %in% c(1, 2)) %>% # exclude 2010 count & baseline
#   mutate(year = DATE_CODE + 2007) %>% # DATE 3 = 2010, so add 2007
#   select(GEOID, year, pop = POP)

# For 2020-2023: Use tidycensus time series 2024 vintage estimates
# (to access Population Estimates Program (PEP) datasets)
pop_cty_2020_2023 <- tidycensus::get_estimates(
  geography = "county",
  product = "population",
  time_series = TRUE,
  vintage = 2024
)

pop_state_2020_2023 <- tidycensus::get_estimates(
  geography = "state",
  product = "population",
  time_series = TRUE,
  vintage = 2024
)

pop_2020_2023 <- bind_rows(pop_cty_2020_2023, pop_state_2020_2023) %>%
  filter(
    variable == "POPESTIMATE",
    year != 2024
  ) %>%
  select(GEOID, year, pop = value)

pop_est <- bind_rows(pop_2001_2009, pop_2010_2019, pop_2020_2023)

# Load Lyme disease case data
lyme_cty <- fread("data/ld-case-counts-cty-2001-2023.csv") %>%
  janitor::clean_names() %>%
  pivot_longer(
    cols = starts_with("cases"),
    names_to = "year",
    names_prefix = "cases",
    values_to = "cases"
  ) %>%
  mutate(
    ctyname = str_remove(ctyname, " County"),
    GEOID = sprintf("%02d%03d", stcode, ctycode),
    year = as.numeric(year)
  ) %>%
  select(-ctycode)

lyme_state <- lyme_cty %>%
  group_by(stcode, stname, year, ststatus) %>%
  summarize(cases = sum(as.numeric(cases), na.rm = TRUE), .groups = "drop") %>%
  mutate(
    GEOID = sprintf("%02d", stcode),
    year = as.numeric(year),
    ctyname = NA
  )

lyme_data <- rbind(lyme_cty, lyme_state) %>%
  left_join(pop_est, by = c("GEOID", "year")) %>%
  mutate(
    rate = ifelse(cases > 0, (as.numeric(cases) / pop) * 100000, 0)
  ) %>%
  select(-stcode)

available_years <- lyme_data %>%
  distinct(year) %>%
  pull(year) %>%
  as.numeric()

available_geos <- c(
  "United States",
  lyme_data %>%
    distinct(stname) %>%
    pull(stname)
)

# climate_data <- fread("data/climate_factors.csv")
# tick_habitat <- fread("data/tick_habitat_suitability.csv")

# For now, we'll create sample data in the modules
# When you have real data, load it here so it's available to all users
