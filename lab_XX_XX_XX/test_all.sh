#!/bin/bash

echo "Очистка побочных файлов..."
./clean.sh

echo "Проверка скриптов..."
./test_scripts.sh
result=$?

if [[ $result -ne 0 ]]; then
    echo -e "\033[31mОшибка при тестировании скриптов!\033[0m" >&2
    exit 1
else 
    echo -e "\033[32mВсе скрипты проверены успешно!\033[0m"
fi
echo

cnt_err=0
function test () {
    echo "Сборка проекта при помощи $1..."
    "$1"
    result=$?

    if [[ $result -ne 0 ]]; then
        echo -e "\033[31mОшибка при компиляции программы!\033[0m" >&2
        exit 1
    fi

    ./func_tests/scripts/func_tests.sh
    cnt_err=$((cnt_err+$?))
    echo
}

test ./build_debug.sh
test ./build_debug_asan.sh
test ./build_debug_msan.sh
test ./build_debug_ubsan.sh

./collect_coverage.sh

exit $cnt_err