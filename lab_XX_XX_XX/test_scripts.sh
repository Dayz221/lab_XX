#!/bin/bash

is_err=0
scripts=$(find . -name "*.sh" -type f)
for script in $scripts; do
    shellcheck "$script"
    result=$?
    
    if [[ $result -ne 0 ]]; then
        is_err=1
    fi
done

exit $is_err