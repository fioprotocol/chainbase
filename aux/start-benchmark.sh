#!/bin/bash

set -x;

NUM_OF_SWAPS=5000000;

NUM_OF_ACCOUNTS=( 10000  20000  30000  40000  50000  60000  70000  80000  90000  100000
                 110000 120000 130000 140000 150000 160000 170000 180000 190000  200000
                 210000 220000 230000 240000 250000 260000 270000 280000 290000  300000
                 310000 320000 330000 340000 350000 360000 370000 380000 390000  400000
                 410000 420000 430000 440000 450000 460000 470000 480000 490000  500000
                 510000 520000 530000 540000 550000 560000 570000 580000 590000  600000
                 610000 620000 630000 640000 650000 660000 670000 680000 690000  700000
                 710000 720000 730000 740000 750000 760000 770000 780000 790000  800000
                 810000 820000 830000 840000 850000 860000 870000 880000 890000  900000
                 910000 920000 930000 940000 950000 960000 970000 980000 990000 1000000);

for i in "${NUM_OF_ACCOUNTS[@]}";
do
    DATA_FILE="data_n${i}_w${NUM_OF_SWAPS}.csv";
    METRICS_FILE="metrics_n${i}_w${NUM_OF_SWAPS}.csv";
    
    ./bench-tps -n"$i" -w"$NUM_OF_SWAPS";

    mv ./data.csv $DATA_FILE;
    mv ./metrics.csv $METRICS_FILE;

    VM_USAGE_MODE=$(cut -f 1 $METRICS_FILE);
    TPS_MIN=$(cut -f 2 $METRICS_FILE);
    TPS_25TH_PERCENTILE=$(cut -f 3 $METRICS_FILE);
    TPS_MEDIAN=$(cut -f 4 $METRICS_FILE);
    TPS_75TH_PERCENTILE=$(cut -f 5 $METRICS_FILE);
    TPS_MAX=$(cut -f 6 $METRICS_FILE);
    TPS_MEAN=$(cut -f 7 $METRICS_FILE);

    echo -n "$VM_USAGE_MODE, " >> "cumulative_dataset.csv";
    echo -n "$TPS_MIN, " >> "cumulative_dataset.csv";
    echo -n "$TPS_25TH_PERCENTILE, " >> "cumulative_dataset.csv";
    echo -n "$TPS_MEDIAN, " >> "cumulative_dataset.csv";
    echo -n "$TPS_75TH_PERCENTILE, " >> "cumulative_dataset.csv";
    echo -n "$TPS_MAX, " >> "cumulative_dataset.csv";
    echo    "$TPS_MEAN" >> "cumulative_dataset.csv";

    ls | grep -E [[:alnum:]]+\-[[:alnum:]]+\-[[:alnum:]]+\-[[:alnum:]]+ | xargs rm -r;
done
