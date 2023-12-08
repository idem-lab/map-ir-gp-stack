gbam_rmse <- function(gamb_predict_test,
                      test_data){
  errors <- gamb_predict_test - test_data[, "pcent_mortality"]
  rmse <- sqrt(mean(errors^2))
  rmse
}
