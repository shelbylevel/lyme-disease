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
# lyme_cases <- fread("data/lyme_cases_by_state_year.csv")
# climate_data <- fread("data/climate_factors.csv")
# tick_habitat <- fread("data/tick_habitat_suitability.csv")

# For now, we'll create sample data in the modules
# When you have real data, load it here so it's available to all users
