#' ---
#' title: Time Series CW1
#' author: Muhammad Sameed
#' date: 14/03/2026
#' ---
#'


install.packages("prophet")
library(prophet)

raw_data <- read.csv("car-practical-test-pass-rates-jan-2019-to-nov-2024.csv")

head(raw_data)
names(raw_data)
str(raw_data)

test_passes <- data.frame(
    ds = as.Date(raw_data$Time, format = "%d/%m/%Y"),
    y = as.numeric(gsub(",", "", raw_data$Passed))
)

head(test_passes)
names(test_passes)
str(test_passes)

plot(test_passes$ds, test_passes$y,
     type = "l",
     main = "Number of Practical Driving Passes",
     xlab = "Date",
     ylab = "Passes",
     xaxt = "n")

axis.Date(1,
          at = seq(min(test_passes$ds),
                   max(test_passes$ds),
                   by = "1 year"),
          format = "%Y")

model = prophet(test_passes)

future <- make_future_dataframe(model,
                                periods = 12,
                                freq = "month")

forecast <- predict(model, future)
plot(model, forecast)


