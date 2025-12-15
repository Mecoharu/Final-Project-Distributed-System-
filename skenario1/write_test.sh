#!/bin/bash

MASTER_IP="192.168.122.205"   
PORT=6379
TOTAL_KEYS=1000

START_TIME=$(date +%s.%N)

for i in $(seq 1 $TOTAL_KEYS); do
  redis-cli -h $MASTER_IP -p $PORT SET key$i $i > /dev/null
done

END_TIME=$(date +%s.%N)

WRITE_TIME=$(echo "$END_TIME - $START_TIME" | bc)

echo "Total keys written : $TOTAL_KEYS"
echo "Write time (s)     : $WRITE_TIME"
