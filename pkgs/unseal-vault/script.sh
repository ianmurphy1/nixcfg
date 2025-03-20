#!/usr/bin/env bash
# Script to unseal vault when it restarts
# Take 3 random keys from a file and curl the server
# to unseal
# set -x
set -eo pipefail

VAULT_ADDR="${VAULT_ADDR:?"needs to be set"}"
TOKEN_FILE=${TOKEN_FILE:?"needs to be set"}
TOKENS=($(shuf -n 3 "${TOKEN_FILE}"))

for t in ${TOKENS[@]}; do
	_body=$(jq -c -n --arg token $t '{"key": $token}')
	curl -s \
		-f \
    -w "" \
		-o /dev/null \
		-X POST \
		-d "${_body}" \
		"${VAULT_ADDR}/v1/sys/unseal"
done
