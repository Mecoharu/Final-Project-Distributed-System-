#!/bin/bash

CLUSTER_NODE="192.168.122.00"   # change to any cluster node
PORT=6379

echo "Writing keys to Redis Cluster..."

for i in $(seq 0 10000); do
  redis-cli -c -h $CLUSTER_NODE -p $PORT SET key$i $i > /dev/null
done

echo "Finished writing 10,000 keys"
