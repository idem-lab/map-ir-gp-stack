model_fit_bgam <- function(
    model_formula,
    data,
    tune_run = 1
) {

  # ==== specify hyperparameters =====
  gamb_grid <- expand.grid(mstop = 50)
  gamb_tune_grid <- gamb_grid[tune_run, ]

  # ==== train the model ====
  gbam_fit_train <- gamboost(
    formula = model_formula,
    data = data,
    control = boost_control(
      mstop = gamb_tune_grid,
      nu = 0.4,
      risk = "oobag"
    )
  )

  gbam_fit_train

}
