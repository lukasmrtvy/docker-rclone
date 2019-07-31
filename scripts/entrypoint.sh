#!/bin/bash

export CONFIG_PATH="${CONFIG_PATH:-/home/rclone/.config/rclone/rclone.conf}"

export RCLONE_BACKEND_USER="${RCLONE_BACKEND_USER:-user}"
export RCLONE_BACKEND_PASS="${RCLONE_BACKEND_PASS:-password}"
export RCLONE_BACKEND_PATH="${RCLONE_BACKEND_PATH:-/}"
export RCLONE_BACKEND_ADDR="${RCLONE_BACKEND_ADDR:-0.0.0.0:8080}"

export RCLONE_BACKEND_OPTIONS=("${OVERRIDE_OPTIONS}")

if [ -f "${CONFIG_PATH}" ] || [ "${LOAD_RCLONE_CONFIG_FROM_ENV,,}" == "true" ]; then
        if [ -n "${RCLONE_BACKEND}" ] && [ -n "${RCLONE_BACKEND_PROTOCOL}" ];then
                exec $(eval echo "$@")
        else
                exit 1
        fi
else
        echo "Config does not exist, please create config first"
        exit 1
fi
