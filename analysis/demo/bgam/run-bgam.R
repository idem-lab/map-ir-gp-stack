source("analysis/demo/bgam/packages.R")
source(here("analysis/demo/bgam/load_gen.r"))
source(here("analysis/demo/bgam/fit-bgam.R"))
data_all <- read_rds(
  here("analysis/demo/bgam/data/data_all_wa.rds")
  )
covariate_names <- read_rds(
  here("analysis/demo/bgam/data/covariate_names_all_wa.rds")
  )
factor_cov_nms <- read_rds(
  here("analysis/demo/bgam/data/factor_cov_nms.rds")
  )
inner_test_index_list <- read_rds(
  here("analysis/demo/bgam/data/inner_test_index_list.rds")
  )

outer_test_index_list <- read_rds(
  here("analysis/demo/bgam/data/outer_test_index_list.rds")
  )


fitted_bgam_1_1 <- fit_bgam(
    data_all = data_all,
    covariate_names = covariate_names,
    factor_cov_nms = factor_cov_nms,
    inner_test_index_list = inner_test_index_list,
    outer_test_index_list = outer_test_index_list,
    tune_run = 1,
    outer_validation = 1,
    inner_validation = 1
)

# previous_model_run_1_1 <-
load(
  here("analysis/demo/bgam/model-output/gamb_pred_val_run1_1.RData")
)

# are out outputs roughly the same?
all.equal(fitted_bgam_1_1$rmse, output$rmse)
all.equal(fitted_bgam_1_1$data_all, output$data_all)
all.equal(fitted_bgam_1_1$gambPredJ, output$gambPredJ)
all.equal(fitted_bgam_1_1$test_inds, output$test_inds)
