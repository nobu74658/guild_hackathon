#!/bin/bash

set -eu

: "${KNITTING_SERVER_DB_NAME}"

docker compose exec -T mysql mysql -e "CREATE DATABASE IF NOT EXISTS \`${KNITTING_SERVER_DB_NAME}\`;"
goose up
