#!/bin/bash
# the VMware host advertises a new preferred mode when its window is resized, and i3 has no xfsettingsd to apply it
output=$(xrandr --query | awk '/ connected/ {print $1; exit}')

fit() {
    # a preferred mode carrying no active marker means the host resized and X has not followed
    xrandr --query | sed -n "/^$output connected/,/^[^ ]/{/^ /p}" |
        awk '/\+/ && !/\*/ {f=1} END {exit !f}' && xrandr --output "$output" --auto
}

fit
xev -root -event randr | while IFS= read -r line; do
    case "$line" in *RRScreenChangeNotify*) fit ;; esac
done
