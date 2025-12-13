#!/bin/bash

MASTER_IP="192.168.122.205"   # initial master
PORT=6379

i=1
echo "Writing continuously to Redis..."

while true; do
  redis-cli -h $MASTER_IP -p $PORT SET failover_key_$i $i > /dev/null
  echo "SET failover_key_$i"
  i=$((i+1))
  sleep 0.2
done
