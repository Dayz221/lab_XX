#!/bin/bash

clang -std=c99 -Wall -Werror -Wextra -Wpedantic -Wfloat-equal -Wfloat-conversion -Wvla -fsanitize=address -fno-omit-frame-pointer -g -o app.exe main.c -lm
exit $?
