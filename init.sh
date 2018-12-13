#!/usr/bin/env bash

echo "Setup environment..."

if [[ -n "$1" ]]; then
    cp -i resources/Homestead.json Homestead.json
else
    cp -i resources/Homestead.yaml Homestead.yaml
fi

cp -i resources/after.sh after.sh
cp -i resources/aliases aliases

./resources/key.sh

echo #
echo "Homestead initialized!"
