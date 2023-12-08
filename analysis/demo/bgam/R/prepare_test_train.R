prepare_test_train <- function(data,
                               outer_test_index_list,
                               inner_test_index_list,
                               inner_validation,
                               outer_validation,
                               covariate_names){

# ==== manage test and training indices for data ====
# Select indices for the validation set excluding indices in the test set
test_inds_a <- inner_test_index_list[[inner_validation]]

# Select indices for outer test set
outer_test_index <- unlist(outer_test_index_list[[outer_validation]])

test_inds <- test_inds_a[which(!is.element(test_inds_a, outer_test_index))]
test_data <- data[test_inds, c("pcent_mortality", covariate_names, "int")]
train_data <- data[-test_inds, c("pcent_mortality", covariate_names, "int")]

data_i <- rbind(train_data, test_data)
train_inds <- c(1:nrow(data))[-test_inds]
data_i <- data_i[order(c(train_inds, test_inds)), ]
data_i <- droplevels(data_i)
test_data <- data_i[test_inds, ]
train_data <- data_i[-test_inds, ]

list(
  test_data = test_data,
  train_data = train_data,
  test_inds = test_inds,
  train_inds = train_inds
)

}
