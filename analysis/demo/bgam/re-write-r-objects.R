load(here::here("analysis/demo/bgam/inputs_data_all_wa_fact5d.r"))


readr::write_rds(
  x = inputs,
  file = here::here("analysis/demo/bgam/data/inputs_data_all_wa_fact5d.rds"),
  compress = "xz"
  )

readr::write_rds(
  x = inputs$data_all_wa,
  file = here::here("analysis/demo/bgam/data/data_all_wa.rds"),
  compress = "xz"
  )

readr::write_rds(
  x = inputs$covariate.names.all.wa,
  file = here::here("analysis/demo/bgam/data/covariate_names_all_wa.rds"),
  compress = "xz"
  )

readr::write_rds(
  x = inputs$factor_cov_nms,
  file = here::here("analysis/demo/bgam/data/factor_cov_nms.rds"),
  compress = "xz"
  )

load(here::here("analysis/demo/bgam/stk_val_inds5.r"))

# str(stk_val_inds)

readr::write_rds(
  x = stk_val_inds,
  file = here::here("analysis/demo/bgam/data/outer_test_index_list.rds"),
  compress = "xz"
)

load(here::here("analysis/demo/bgam/non_spatial_val_sets6.r"))

readr::write_rds(
  x = val_ind,
  file = here::here("analysis/demo/bgam/data/inner_test_index_list.rds"),
  compress = "xz"
)
str(val_ind)
