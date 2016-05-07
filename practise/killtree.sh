#!/usr/bin/env bash


# http://stackoverflow.com/questions/392022/best-way-to-kill-all-child-processes

set -eu

killtree() {
    local pid
    for pid; do
	# SIGSTOP parent if its fork bombing
        kill -stop $pid
        local cpid
	# Find of children and recurse through them
        for cpid in $(pgrep -P $pid); do
            killtree $cpid
        done
	# send SIGTERM which will be queued as SIGSTOP is blocking signal
        kill $pid
	# pass SIGCONT which will allow SIGTERM to reach to that processes
        kill -cont $pid
        wait $pid 2>/dev/null || true
   done
}

cpids() {
    local pid=$1 options=${2:-} space=${3:-}
    local cpid
    for cpid in $(pgrep -P $pid); do
        echo "$space$cpid"
        if [[ "${options/a/}" != "$options" ]]; then
            cpids $cpid "$options" "$space  "
        fi
    done
}

while true; do sleep 1; done &
cpid=$!
for i in $(seq 1 2); do
    cpids $$ a
    sleep 1
done
killtree $cpid
echo ---
cpids $$ a
