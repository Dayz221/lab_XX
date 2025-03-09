#!/bin/bash

echo "Компиляция отладочной версии программы..."
./build_coverage.sh
result=$?

if [[ $result -ne 0 ]]; then
    echo -e "\033[31mОшибка компиляции!\033[0m" >&2
    exit 1
fi

echo "Тестирование..."
./func_tests/scripts/func_tests.sh
result=$?

if [[ $result -ne 0 ]]; then
    echo -e "\033[31mБыли пройдены не все тесты!\033[0m" >&2
    exit 2
fi

result=$(gcov app-main | grep -o -m 1 "[0-9]*.[0-9]*%")
echo -e "\033[96mРезультат тестирования покрытия:\033[0m $result"

if [[ $result != "100.00%" ]]; then
    exit 3
fi