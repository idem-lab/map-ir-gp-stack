These notes will serve as a working document to describe on the changes I've made to this directory, and why. Hopefully this should make it clearer for myself and for others the reasons for restructuring this repository.

The overall goal for this analysis is to generate predictions on a test set containing results of standard insecticide susceptibility tests using a set of predictor variables. There are several layers to this, as it works on inner and outer validation sets.

- Produce 10-fold out-of-sample inner validation results for the BGAM model, for a given outer validation set (from a set of 10 outer validation sets).

They currently have this written as a set of Rscripts that control the function arguments. My understanding is that this would make things easier to run on a HPC or other server.

Currently, the process is, say, to run from the command line something like:

```
Rscript pred_runs_val_gamb_ind.r 2 3 
```

This will run the BGAM for outer validation set 2 and inner validation set 3.

I would like to change this into an R function, or separate it out into several.

There are also some data files, which are saved with `.r` extension, I believe that these are `.Rdata` files, which contain multiple objects. These should be separated out so all of the inputs can be clearly defined. 

Data files:
- "inputs_data_all_wa_fact5d.r": Data set with all the labels (bioassay proportional mortality) and features (predictor variables)
- "non_spatial_val_sets6.r": indices for the inner validation loop
- "stk_val_inds5.r": indices for the outer validation loop

Source files:
- "load_gen.r" : source code for other R functions
- "pred_runs_val_gamb_ind.r": function for calling the boost script
- "l0_pred_fn_val_gamb_ind.r": function for formatting the input data and training the boosted gam

It produces some output of the model, `gamb_pred_val_run2_3.RData`,which is saved in an .Rdata file, which has to be loaded into the R session with `load`. This contains an object called `output`, which is a list with the following elements:
  1. rmse: the root mean squared error of the out-of-sample predictions.
  2. gambFitJ: the fitted model
  3. gambPredJ: a vector of predicted values
  4. test_inds: the indices of the row numbers of the test set in the full data file
  5. data_all: the full input data set.

## Some initial code review notes

This repo should separate out the data into a data directory within this repository. If these are the data are used in each folder, then they should not be repeated over all the repositories.

I need to establish a set of testing data that I can validate the changes to the code on. Accordingly, I'm going to run all of the model outputs.

The first goal is to instead of run things from the terminal, to be able to run them from within R.

- Functions etc are stored in `load_gen.r`
- The main code file is `l0_pred_fn_val_gamb_ind.r`
- The inputs to this are being handled by `pred_runs_val_gamb_ind.R`
- It looks like `load_gen.r` is duplicated across every single directory.

Reading the code in `l0_pred_fn_val_gamb_ind.r`, it seems to follow this pattern:

1. print tune and outer and inner validation sets. The outer validation set is `val_run`, and the inner validation set is `val_run2`.


The pieces of complexity that are managed here are:

- Managing the indexing for the inner and outer validation sets
- Doing emplogit transform on labels (I think that is `pcent_mortality`), then doing MLE to choose theta parameters
- constructing hyperparameter grid
- Making specific format changes for BGAM - building formulas, etc
- Managing the construction of the test and training data
- model fitting on training data
- predicting to test data
- calculating RMSE
- building output object that contains:
  - rmse
  - training model
  - model predictions on test data
  - test data
  - the entire dataset, I think from `inputs_data_all_wa_fact5d.r`
  
Some notes on this process:

- A lot of this complexity can be managed with something like `tidymodels` and co
- managing the test and training set is hard to understand exactly what is happening with that process, as it relies on `stk_val_inds`, the indices for the outer test set.
- And so I am currently unclear what the process is with the outer and inner validation sets. Once I understand that, I think I will know how to start attacking this.
- I am unclear how the results from each of these models (bgam, rf, xgb) is combined, or if there is an order that these models are run.
- it looks like bgam is only being fit once, and not iterating through the inner and outer loops?


- [x] Code needs to be styled
- [] library calls should be moved up to a higher level R file and stored there
- [] 
- []

