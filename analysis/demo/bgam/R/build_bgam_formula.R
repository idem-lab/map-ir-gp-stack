build_bgam_formula <- function(factor_cov_nms,
                               covariate_names){

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


}
