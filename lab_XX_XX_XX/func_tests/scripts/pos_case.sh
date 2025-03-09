#!/bin/bash

if [[ $# -ne 2 ]]; then
	exit 2
fi

if [[ ! -f $1 || ! -f $2 ]]; then
	exit 3
fi

basename=$(basename "$1")
test_name=${basename%_in.txt}
sctipt_dir=$(dirname "$(realpath "$0")")

"$sctipt_dir/../../app.exe" < "$1" > "$test_name.tmp"
result_app=$?

"$sctipt_dir/comparator.sh" "$test_name.tmp" "$2"
result_comparator=$?

summ=$((result_app+result_comparator))
if [[ $summ -ne 0 ]]; then
    exit 1
fi
