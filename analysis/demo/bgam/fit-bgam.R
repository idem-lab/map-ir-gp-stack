fit_bgam <- function(
    data_all,
    covariate_names,
    factor_cov_nms,
    inner_test_index_list,
    outer_test_index_list,
    tune_run = 1,
    outer_validation = 1,
    inner_validation = 1
    ) {

  # ==== Create pcent_mortality transformed variable ====
  # Empirical logit and IHS transform on labels
  data_all[, "pcent_mortality"] <- emplogit2(
    data_all["no_dead"],
    data_all["no_tested"]
    )

  theta2 <- optimise(
    f = IHS.loglik,
    lower = 0.001,
    upper = 50,
    x = data_all[, "pcent_mortality"],
    maximum = TRUE
    )

  data_all[, "pcent_mortality"] <- IHS(
    data_all[, "pcent_mortality"],
    theta2$maximum
    )

  # add an intercept
  data_all$int <- 1

  # ==== manage test and training indices for data ====
  # Select indices for the validation set excluding indices in the test set
  test_inds_a <- inner_test_index_list[[inner_validation]]

  # Select indices for outer test set
  outer_test_index <- unlist(outer_test_index_list[[outer_validation]])

  test_inds <- test_inds_a[which(!is.element(test_inds_a, outer_test_index))]
  test_data <- data_all[test_inds, c("pcent_mortality", covariate_names, "int")]
  train_data <- data_all[-test_inds, c("pcent_mortality", covariate_names, "int")]

  data_all_i <- rbind(train_data, test_data)
  train_inds <- c(1:nrow(data_all))[-test_inds]
  data_all_i <- data_all_i[order(c(train_inds, test_inds)), ]
  data_all_i <- droplevels(data_all_i)
  test_data <- data_all_i[test_inds, ]
  train_data <- data_all_i[-test_inds, ]

  # ==== build formula for bgam ====
  covariate_names_a <- factor_cov_nms
  # setting this up to remove "covariate_names_a" from "covariate_names"
  cts_cov_inds <- which(!is.element(covariate_names, covariate_names_a))
  # bols & bbs model for continuous covariates with df=1
  # (see Hofner et al. 2014 "Model-based boosting in R")
  covariate_names_b <- covariate_names[cts_cov_inds]

  # bols model for factor covariates
  covariate_names_a <- glue("bols({covariate_names_a}, df = 1)")

  covariate_names_b <- glue(
    "bbs({covariate_names_b}, center = TRUE, df = 1) + \\
    bols({covariate_names_b}, intercept = FALSE)"
        )

  covariate_names_b <- c("bols(int,intercept=FALSE)", covariate_names_b)

  covariate_names_a_b <- c(covariate_names_a, covariate_names_b)

  model_lhs <- paste(covariate_names_a_b, collapse = "+")

  form <- as.formula(paste("pcent_mortality", model_lhs, sep = "~"))

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

  # ==== Get out of sample predictions ====
  gamb_predict_test <- predict(gamb_fit_train, newdata = test_data)

  # ==== calculate rmse ====
  errors <- gamb_predict_test - data_all[test_inds, "pcent_mortality"]
  rmse <- sqrt(mean(errors^2))

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
