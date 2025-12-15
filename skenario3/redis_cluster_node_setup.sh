#!/bin/bash
set -e

# Install Redis
apt update -y
apt install -y redis-server redis-tools

# Stop Redis if already running
pkill redis-server 2>/dev/null || true
sleep 1

# Start Redis in cluster mode (non-systemd, GNS3-safe)
redis-server \
  --port 6379 \
  --bind 0.0.0.0 \
  --protected-mode no \
  --cluster-enabled yes \
  --cluster-config-file nodes.conf \
  --cluster-node-timeout 5000 \
  --appendonly yes \
  --daemonize yes

# Verify Redis
redis-cli ping
redis-cli info cluster | grep cluster_enabled
