#!/bin/sh

AGE_KEY_FILE=~/.config/age/master.key.txt

if [ -f "$AGE_KEY_FILE" ]; then
    echo "Key already exists"
    exit 0
fi
if [ -z "${CHEZMOI_AGE_KEY}" ]; then
    echo "CHEZMOI_AGE_KEY is not set"
    exit 1
fi

mkdir -p $(dirname "$AGE_KEY_FILE")

echo "$CHEZMOI_AGE_KEY" > "$AGE_KEY_FILE"

