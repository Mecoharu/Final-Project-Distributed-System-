#!/bin/bash

NEW_MASTER_IP="192.168.122.60"   # promoted replica
PORT=6379
MISSING=0

echo "Checking data after failover..."

for i in $(seq 1 50); do
  VALUE=$(redis-cli -h $NEW_MASTER_IP -p $PORT GET failover_key_$i)
  if [ -z "$VALUE" ]; then
    MISSING=$((MISSING + 1))
  fi
done

echo "Missing keys after failover: $MISSING"
