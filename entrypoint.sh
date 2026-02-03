#!/bin/sh
set -eu

mkdir -p /app/data/auth-cache /app/data/logs
chown -R node:node /app/data

exec su-exec node:node "$@"
