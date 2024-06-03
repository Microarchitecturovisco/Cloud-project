#!/bin/sh

if [ "$#" -lt 4 ]; then
  echo "Usage: $0 timeout host:port/health-endpoint [host:port/health-endpoint ...] command"
  exit 1
fi

timeout="$1"
shift

# Collect host:port pairs with optional health endpoints
services=()
while [ "$#" -gt 1 ]; do
  if [ "$1" = "--" ]; then
    shift
    break
  fi
  services+=("$1")
  shift
done

cmd="$@"

end_time=$(( $(date +%s) + timeout ))

for hostport in "${services[@]}"; do
  while [ $(date +%s) -lt $end_time ]; do
    if curl --fail --silent "http://$hostport" | grep "UP" > /dev/null; then
      echo "Service $hostport is available"
      break
    fi
    echo "Waiting for $hostport..."
    sleep 2
  done
  if [ $(date +%s) -ge $end_time ]; then
    echo "Timed out waiting for $hostport"
    exit 1
  fi
done

echo "All services are available, continuing..."
exec $cmd