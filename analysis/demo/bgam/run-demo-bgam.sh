for i in {1..10}
do
    for j in {1..10}
    do
        Rscript pred_runs_val_gamb_ind.r $i $j
    done
done
