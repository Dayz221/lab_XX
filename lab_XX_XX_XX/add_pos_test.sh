#!/bin/bash

num=$(find ./func_tests/data/ -name "pos_??_in.txt" | wc -l)

while true; do
    num=$((num + 1))
    cur_in_file="./func_tests/data/pos_$(printf "%02d" $num)_in.txt"
    cur_out_file="./func_tests/data/pos_$(printf "%02d" $num)_out.txt"
    
    echo "Введите содержимое файла $cur_in_file"
    while IFS= read -r line; do
        echo "$line" >> "$cur_in_file"
    done
    
    echo "Введите содержимое файла $cur_out_file"
    while IFS= read -r line; do
        echo "$line" >> "$cur_out_file"
    done
done