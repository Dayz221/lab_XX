#!/bin/bash

# Компиляция
gcc -std=c99 -Wall -Werror -Wextra -Wpedantic -Wfloat-equal -Wfloat-conversion -Wvla -O0 -g -c -o debug.o main.c
result=$?

if [[ $result -ne 0 ]]; then 
    exit 1
fi

# Компоновка
gcc debug.o -o app.exe -lm
result=$?

if [[ $result -ne 0 ]]; then 
    exit 2
fi
