#!/usr/bin/env bash
awk -F"[][]" '/Left:/ { print $2 }' <(amixer sget Master)
