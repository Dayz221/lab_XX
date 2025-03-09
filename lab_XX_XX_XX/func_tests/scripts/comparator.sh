#!/bin/bash

verbose=0

if [[ $# -ne 2 && $# -ne 3 ]]; then
	echo "Неверное количество аргументов! Пример запуска: ./comparator.sh <file1> <file2> [-v]" >&2
	exit 2
elif [[ $# -eq 3 ]]; then
	if [[ $3 == '-v' ]]; then
		verbose=1
	else
		echo "Неизвестный флаг $3! Пример запуска: ./comparator.sh <file1> <file2> [-v]" >&2
		exit 3
	fi	
fi

if [[ ! -f $1 ]]; then
	echo "Файл $1 не найден!" >&2
	exit 4
fi

if [[ ! -f $2 ]]; then
	echo "Файл $2 не найден!" >&2
	exit 4
fi

tmp1=$(mktemp)
tmp2=$(mktemp)

grep -o "[^[:space:]]\+" "$1" | grep -oE "^[+-]?(([0-9]+\.[0-9]+)|([0-9]+\.)|(\.?[0-9]+))([eE][+-]?[0-9]+)?$" > "$tmp1"
grep -o "[^[:space:]]\+" "$2" | grep -oE "^[+-]?(([0-9]+\.[0-9]+)|([0-9]+\.)|(\.?[0-9]+))([eE][+-]?[0-9]+)?$" > "$tmp2"

if [[ $verbose -eq 1 ]]; then
	echo "Числа в 1 файле:"
	cat "$tmp1"
	echo "Числа во 2 файле:"
	cat "$tmp2"
fi

cmp --q "$tmp1" "$tmp2"
result=$?
rm "$tmp1" "$tmp2"

if [[ $result -eq 0 ]]; then
	if [[ $verbose -eq 1 ]]; then echo "Числа совпадают!"
	fi
	exit 0
else
	if [[ $verbose -eq 1 ]]; then echo "Числа не совпадают!"
	fi
	exit 1
fi
