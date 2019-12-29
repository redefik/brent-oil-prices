################################################################################
#This project deals with the analysis of a time series containing daily Brent  #
#oil prices from 1987-17-05 to 2019-30-09. The focus is mainly on stationarity.#
#Making a time series stationary is a fundamental task in many circumnstances, #
#especially in forecasting.                                                    #
#The dataset is available at:                                                  #
#https://www.kaggle.com/mabusalah/brent-oil-prices                             #
################################################################################

library(fpp2)
library(tseries)

source("import_dataset.R")
source("data_understanding.R")

# Dataset import
data <- import_dataset("BrentOilPrices.csv")

# Data Understanding
data_summary <- data_understanding(data)

# The dataset include 8216 instances. For each instance we have the price of the
# Brent Oil (the oil extracted from the North Sea) and the day when that price
# was registered. The price is expressed in US Dollars per Barrel.
# There are no duplicated instances and no missing values. 
# Moreover, in this analysis we ignore the effect of inflation.

# For sake of simplicity, we truncate the dataset considering only data between
# January 1988 and December 2018.
trunc_data <- data[161:8024, 2]
# Furthermore, we assume that for each week five observations are available 
# (trading are closed on Saturday and Sunday).
# It is an aprroximation (what about Christmas and similar?) but for our aim it 
# is a reasonable compromise.

# In conclusion, no particular pre-processing is needed

# Embed time series inside a ts object. According to the previous considerations
# we set frequency to 260 (number of days in year without Saturday and Sunday)
time_series <- ts(data[,2], start=1988, frequency = 260)

# Display time plot
autoplot(time_series) +
  ggtitle("Daily Brent Oil Price") +
  xlab("Year") +
  ylab("Dollars/barrel")

# The time plot reveals a cyclic behaviour. Namedly, an evident fall appears to
# be around the year 2009. This is due for sure to the great economic crisis.
# Another fall appears around the year 2015. A new rise is registered around
# 2016 and it is probably related to the OCSE agreement.

# As usual, we estimate the trend using a simple moving average
# If we assume annual seasonality we have to use a centered average of order 260
trend_estimate <- ma(time_series, 260, centre=TRUE)
# Let's compare estimate trend and original time series
autoplot(time_series, series="Original") +
  autolayer(trend_estimate, series="260-MA centred") +
  xlab("Year") + ylab("Dollars/barrel") +
  ggtitle("Daily Brent Oil Price") +
  scale_colour_manual(values=c("Original"="grey","260-MA centred"="red"),
                      breaks=c("Original","260-MA centred"))


# To investigate the stationarity let's plot ACF
autoplot(Acf(time_series)) +
  ggtitle("ACF Daily Brent Oil Price")

# Besides the ugliness of the plot, it seems that there is no stationarity at
# all. For more rigorous conclusion, lets'apply a statistical test.
# Namely, we apply the Augmented Dickey Fuller Test.
# Null Hypotesis: the time series is not stationary
adf.test(time_series)
# The returned p-value is 0.3978 > 0.01, thus we cannot reject the null hypotesis
# with significance level alpha=0.01 i.e. time series is not stationary



