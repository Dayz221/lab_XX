#!/bin/bash

sctipt_dir=$(dirname "$(realpath "$0")")

pos_tests=$(find "$sctipt_dir/../data/" -type f -name "pos_??_in.txt" | sort)
cnt_pos_tests=$(find "$sctipt_dir/../data/" -type f -name "pos_??_in.txt" | wc -l)
echo "Количество позитивных тестов: $cnt_pos_tests"

cnt_ok=0
cnt_err=0
for pos_test in $pos_tests; do
    basename=$(basename "$pos_test")
    test_name=${basename%_in.txt}

    "$sctipt_dir/pos_case.sh" "$pos_test" "$sctipt_dir/../data/${test_name}_out.txt"
    result=$?

    if [[ $result -eq 0 ]]; then
        echo -e "Тест $test_name \033[32mПРОЙДЕН\033[0m"
        cnt_ok=$((cnt_ok+1))
    else
        echo -e "Тест $test_name \033[31mНЕ ПРОЙДЕН\033[0m"
        cnt_err=$((cnt_err+1))
    fi
done

echo "Всего пройдено $cnt_ok/$cnt_pos_tests позитивных тестов!"

neg_tests=$(find "$sctipt_dir/../data/" -type f -name "neg_??_in.txt" | sort)
cnt_neg_tests=$(find "$sctipt_dir/../data/" -type f -name "neg_??_in.txt" | wc -l)
echo "Количество негативных тестов: $cnt_neg_tests"

cnt_ok=0
for neg_test in $neg_tests; do
    basename=$(basename "$neg_test")
    test_name=${basename%_in.txt}

    "$sctipt_dir/neg_case.sh" "$neg_test"
    result=$?

    if [[ $result -eq 0 ]]; then
        echo -e "Тест $test_name \033[32mПРОЙДЕН\033[0m"
        cnt_ok=$((cnt_ok+1))
    else
        echo -e "Тест $test_name \033[31mНЕ ПРОЙДЕН\033[0m"
        cnt_err=$((cnt_err+1))
    fi
done

echo "Всего пройдено $cnt_ok/$cnt_neg_tests негативных тестов!"

exit $cnt_err
