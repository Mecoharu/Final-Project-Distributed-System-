#!/bin/bash
set -e

MASTER_IP="192.168.122.205"  

apt update -y
apt install -y redis-server redis-tools bc

pkill redis-server 2>/dev/null || true

redis-server \
  --port 6379 \
  --bind 0.0.0.0 \
  --replicaof $MASTER_IP 6379 \
  --protected-mode no \
  --daemonize yes

sleep 2

redis-cli INFO replication | grep -E "role|master_host|master_link_status"


