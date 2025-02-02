R Code for running the Random Forest (RF) modelling analysis described in:

Hancock PA, Hendriks CJM, Tangena J-A, Gibson H, Hemingway J, Coleman M, Gething PW, Bhatt S, Moyes CL, “Mapping trends in insecticide resistance phenotypes in African malaria vectors”.

The RF model generates predictions on a test set containing results of standard insecticide susceptibility tests using a set of predictor variables.

System requirements: This code is written in R software, which runs on a wide variety of UNIX platforms, Windows and Mac OS. The R software is quick to install.

Software requirements: R, using the following packages:
caret
data.table
LaplacesDemon
zoo

This code has been tested on R version 3.4.3 with the package caret version 6.0_81, the package data.table version 1.10.4-3, the package LaplacesDemon version 16.1.0 and the package zoo version 1.8-2.

Instructions for reproducing the 10-fold out-of-sample inner validation results for the RF model for a given outer validation set (from a set of 10 outer validation sets) are as follows:

For outer validation set 2 run from the terminal command line:

Rscript pred_runs_val_rf.r 2

This script runs all inner validation sets.

This script requires the following the input following files:
1. "inputs_data_all_wa_tree5d.r": Data set with all the labels (bioassay proportional mortality) and features (predictor variables)
2. "load_gen.r" : source code for other R functions
3. "non_spatial_val_sets6.r": indices for the inner validation loop
4. "stk_val_inds5.r": indices for the outer validation loop
5. "pred_runs_val_rf.r”: function for calling the random forest script
6. "l0_pred_fn_val_rf.r”: function for formatting the input data and training the random forest model
