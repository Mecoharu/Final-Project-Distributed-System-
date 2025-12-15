#!/bin/bash
set -e

REDIS_NODES=(
  192.168.122.88:6379
  192.168.122.135:6379
  192.168.122.248:6379
  192.168.122.108:6379
  192.168.122.165:6379
  192.168.122.31:6379
)

yes yes | redis-cli --cluster create \
  ${REDIS_NODES[@]} \
  --cluster-replicas 1

redis-cli -c cluster info
redis-cli -c cluster nodes

for i in $(seq 0 10000); do
  redis-cli -c SET key$i "value-$i" > /dev/null
done

for k in key0 key123 key5000 key9999; do
  redis-cli -c cluster keyslot $k
done
