#!/bin/bash

if [[ $# -ne 1 ]]; then
	exit 2
fi

if [[ ! -f "$1" ]]; then
	exit 3
fi

sctipt_dir=$(dirname "$(realpath "$0")")

"$sctipt_dir/../../app.exe" < "$1" > /dev/null
result_app=$?

if [[ $result_app -eq 0 ]]; then
    exit 1
else
    exit 0
fi
