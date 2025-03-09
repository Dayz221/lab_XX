#!/bin/bash

black_list="*.gcda *.gcno *.gcov *.o *.exe *.tmp"

for extension in $black_list; do
    find . -type f -name "$extension" -delete
done
