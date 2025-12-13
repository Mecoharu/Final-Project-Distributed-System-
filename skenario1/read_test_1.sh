#!/bin/bash

REPLICA_IP="192.168.122.60"
PORT=6379
MISSING=0

for i in $(seq 1 1000); do
  VALUE=$(redis-cli -h $REPLICA_IP -p $PORT GET key$i)
  if [ -z "$VALUE" ]; then
    MISSING=$((MISSING + 1))
  fi
done

echo "Missing keys on replica: $MISSING"
