#!/bin/bash

wait_for_service() {
    local hostport=$1
    local timeout=$2

    host=$(echo "$hostport" | cut -d':' -f1)
    port=$(echo "$hostport" | cut -d':' -f2)

    end_time=$(( $(date +%s) + timeout ))

    while [ $(date +%s) -lt $end_time ]; do
        if nc -z "$host" "$port"; then
            echo "Service $hostport is available"
            return 0
        fi
        echo "Waiting for $hostport..."
        sleep 2
    done

    echo "Timed out waiting for $hostport"
    return 1
}

echo "Waiting for services..."

wait_for_service "discovery:8089" 120 || exit 1

wait_for_service "config:8012" 120 || exit 1

echo "All services are available!"
