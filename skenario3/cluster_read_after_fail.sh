#!/bin/bash

CLUSTER_NODE="192.168.122.00"   # change to any surviving node
PORT=6379
MISSING=0

echo "Checking key availability after shard failure..."

for i in $(seq 0 10000); do  
  VALUE=$(redis-cli -c -h $CLUSTER_NODE -p $PORT GET key$i)
  if [ -z "$VALUE" ]; then
    MISSING=$((MISSING + 1))
  fi
done

echo "Missing keys after shard failover: $MISSING"
