################################################################################
#This project deals with the analysis of a time series containing daily Brent  #
#oil prices from 1987-17-05 to 2019-30-09. The focus is mainly on stationarity.#
#Making a time series stationary is a fundamental task in many circumnstances, #
#especially in forecasting.                                                    #
#The dataset is available at:                                                  #
#https://www.kaggle.com/mabusalah/brent-oil-prices                             #
################################################################################

source("import_dataset.R")
source("data_understanding.R")

# Dataset import
data <- import_dataset("BrentOilPrices.csv")

# Data Understanding
data_summary <- data_understanding(data)

# The dataset include 8216 instances. For each instance we have the day when the
# price was registered and the corresponding price (in USD).
# There are no duplicated instances and no missing values

