This directory contains code for running the Gaussian process stacked generalisation analysis for spatiotemporal prediction of insecticide resistance phenotypes described in:

Hancock PA, Hendriks CJM, Tangena J-A, Gibson H, Hemingway J, Coleman M, Gething PW, Bhatt S, Moyes CL, "Mapping trends in insecticide resistance phenotypes in African malaria vectors".

Individual directories contain the code for running the level-0 machine-learning models, including the extreme gradient boosting (xgb), random forest (rf) and boosted generalised additive (bgam) models, and the gaussian process meta-model (gp meta-model).

System requirements: This code is written in R software, which runs on a wide variety of UNIX platforms, Windows and Mac OS. The R software is quick to install.

Software requirements: R, using the following packages:
R-INLA
LaplacesDemon
zoo
mboost
xgboost
data.table
caret

This code has been tested on R version 3.4.3 with the package R-INLA version 17.06.2, the package LaplacesDemon version 16.1.0, the package zoo version 1.8-2, the package caret version 6.0_81, the package xgboost version 0.6-4, the package mboost version 2.9-0 and the package data.table version 1.10.4-3.
