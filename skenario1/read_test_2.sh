#!/bin/bash

REPLICA_IP="192.168.122.110"   
PORT=6379
TOTAL_KEYS=1000

MISSING=0
WRONG=0

START_TIME=$(date +%s.%N)

for i in $(seq 1 $TOTAL_KEYS); do
  VALUE=$(redis-cli -h $REPLICA_IP -p $PORT GET key$i)

  if [ -z "$VALUE" ]; then
    MISSING=$((MISSING + 1))
  elif [ "$VALUE" != "$i" ]; then
    WRONG=$((WRONG + 1))
  fi
done

END_TIME=$(date +%s.%N)

ELAPSED=$(echo "$END_TIME - $START_TIME" | bc)

echo "Missing keys : $MISSING"
echo "Wrong values : $WRONG"
echo "Read time (s): $ELAPSED"
