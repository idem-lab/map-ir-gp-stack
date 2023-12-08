DEMO of the R Code for running the Extreme Gradient Boosting (XGB) modelling analysis described in:

Hancock PA, Hendriks CJM, Tangena J-A, Gibson H, Hemingway J, Coleman M, Gething PW, Bhatt S, Moyes CL, “Mapping trends in insecticide resistance phenotypes in African malaria vectors”.

The XGB model generates predictions on a test set containing results of standard insecticide susceptibility tests using a set of predictor variables.

System requirements: This code is written in R software, which runs on a wide variety of UNIX platforms, Windows and Mac OS. The R software is quick to install.

Software requirements: R, using the following packages: 
xgboost
data.table
LaplacesDemon
zoo

This code has been tested on R version 3.4.3 with the package xgboost version 0.6-4, the package data.table version 1.10.4-3, the package LaplacesDemon version 16.1.0 and the package zoo version 1.8-2.

This demo version demonstrates the procedure for obtaining 10-fold out-of-sample inner validation results for the XGB model for a given outer validation set (from a set of 10 outer validation sets).

It runs the first 50 iterations of the XGB model. This should take less than 5 minutes to run.

For outer validation set 2 and inner validation set 3, run from the terminal command line:

Rscript pred_runs_val_xgb_ind.r 2 3

The expected output is contained in the file “xgb_pred_val_run2_3.r”. The output list contains the following elements:
1.l0_run: the number of the inner validation set (from 1-10).
2. xgbFitJ: the fitted model.
3. xgbPredJ: a vector of predicted values
4. test_inds_all: the indices of the row numbers of the test set in the full data file
5. data_all: the full input data set.

This script requires the following the input following files:
1. "inputs_data_all_wa_tree5d.r": Data set with all the labels (bioassay proportional mortality) and features (predictor variables)
2. "invelogit2.r" : source code for performing the empirical logit transform
3. "load_gen.r" : source code for other R functions
4. "non_spatial_val_sets6.r": indices for the inner validation loop
5. "stk_val_inds5.r": indices for the outer validation loop
6. "pred_runs_val_xgb_ind.r": function for calling the xgboost script
7. "l0_pred_fn_val_xgb_ind.r": function for formatting the input data and training the xgboost model
