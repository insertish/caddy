#!/bin/sh
docker-compose exec caddy caddy fmt --overwrite /etc/caddy/Caddyfile
