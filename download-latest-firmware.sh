#!bash

mkdir -p firmware
rm -rf firmware/*
cd firmware
gh run list -R rtward/zmk-config --workflow="Build ZMK Firmware" --limit 1 --json databaseId | jq -r '.[0].databaseId' | xargs -I {} gh run download {} -R rtward/zmk-config -n firmware
