pids="$(pidof -x $(basename $0))"
kill "$(pgrep -x wofi)"
if [[ "$pids" != $$ ]]; then
    exit 1
fi
