#!/bin/sh

AGE_KEY_FILE="~/.config/age/master.key.txt"

if [ -f "$AGE_KEY_FILE" ]; then
    exit 0
fi
if [ ! -z "${AGE_KEY}" ]; then
    exit 1
fi

mkdir -p $(dirname $AGE_KEY_FILE)

echo "${AGE_KEY}" > $AGE_KEY_FILE

