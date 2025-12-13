#!/bin/bash

MASTER_IP="192.168.122.205"
PORT=6379

echo "Writing 1000 keys to master..."

for i in $(seq 1 1000); do
  redis-cli -h $MASTER_IP -p $PORT SET key$i $i > /dev/null
done

echo "Done writing keys"

