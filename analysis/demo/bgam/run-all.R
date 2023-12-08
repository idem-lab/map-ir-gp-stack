# using setwd() willingly here
# to reset later
root_dir <- getwd()
setwd("analysis/demo/bgam/")
# construct system command template
# Rscript pred_runs_val_gamb_ind.r 1 1
system("bash run-demo-bgam.sh")
setwd(root_dir)
