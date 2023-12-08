temporalInfo <- function(f) {
  library(zoo)
  start_dates <- as.yearmon(paste(f[, "year_start"], "-", f[, "month_start"], sep = ""))
  end_dates <- as.yearmon(paste(f[, "year_end"], "-", f[, "month_end"], sep = ""))
  mid_dates <- (start_dates + end_dates) / 2
  return(as.numeric(mid_dates))
}
