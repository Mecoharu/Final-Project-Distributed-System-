apt-get update

apt-get install -y redis-server

redis-server --bind 0.0.0.0 --protected-mode no &
