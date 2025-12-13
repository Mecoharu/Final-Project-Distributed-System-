#!/bin/bash

MASTER="192.168.122.205"
REPLICAS=("192.168.122.60" "192.168.122.164")
PORT=6379

START=$(date +%s%N)
redis-cli -h $MASTER -p $PORT SET lag_test $(date +%s%N)

for REPLICA in "${REPLICAS[@]}"; do
  while true; do
    VALUE=$(redis-cli -h $REPLICA -p $PORT GET lag_test)
    if [ -n "$VALUE" ]; then
      END=$(date +%s%N)
      echo "Replica $REPLICA lag (ns): $((END - START))"
      break
    fi
  done
done
