#!/bin/bash
set -e

apt update -y

apt install -y redis-server redis-tools bc

pkill redis-server 2>/dev/null || true

redis-server \
  --port 6379 \
  --bind 0.0.0.0 \
  --protected-mode no \
  --daemonize yes

sleep 2

redis-cli INFO replication | grep -E "role|connected_slaves"
