#!/bin/sh
# wait-for-services.sh

if [ "$#" -lt 3 ]; then
  echo "Usage: $0 host:port timeout command"
  exit 1
fi

hostport="$1"
timeout="$2"
shift 2
cmd="$@"

host=$(echo "$hostport" | cut -d':' -f1)
port=$(echo "$hostport" | cut -d':' -f2)

end_time=$(( $(date +%s) + timeout ))

while [ $(date +%s) -lt $end_time ]; do
  if curl -sSf "$hostport" &> /dev/null; then
    echo "Service $hostport is available"
    exec $cmd
  fi
  echo "Waiting for $hostport..."
  sleep 2
done

echo "Timed out waiting for $hostport"
exit 1
