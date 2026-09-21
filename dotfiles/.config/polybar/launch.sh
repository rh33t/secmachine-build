#!/usr/bin/env bash
# polybar cannot reload, and i3 re-runs this on every restart
polybar-msg cmd quit >/dev/null 2>&1
while pgrep -u "$UID" -x polybar >/dev/null; do sleep 0.5; done

for monitor in $(polybar -m | cut -d: -f1); do
    MONITOR="$monitor" polybar -r -q main >/dev/null 2>&1 &
done
