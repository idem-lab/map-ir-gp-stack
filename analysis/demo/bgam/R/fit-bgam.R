fit_bgam <- function(
    data_all,
    tune_run = 1
    ) {

  # ==== specify hyperparameters =====
  gamb_grid <- expand.grid(mstop = 50)
  gamb_tune_grid <- gamb_grid[tune_run, ]

  # ==== train the model ====
  gamb_fit_train <- gamboost(
    form,
    data = train_data,
    control = boost_control(
      mstop = gamb_tune_grid,
      nu = 0.4,
      risk = "oobag"
      )
    )

  # ==== construct list of output ====
  output <- list(
    rmse = rmse,
    gambFitJ = gamb_fit_train,
    gambPredJ = gamb_predict_test,
    test_inds = test_inds,
    data_all = data_all
  )

  return(output)
}
