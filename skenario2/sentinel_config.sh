port 6379
sentinel monitor mymaster 192.168.122.22 6379 2
sentinel down-after-milliseconds mymaster 5000
sentinel failover-timeout mymaster 10000
sentinel parallel-syncs mymaster 1
protected-mode no
