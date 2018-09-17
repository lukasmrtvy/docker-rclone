#!/bin/bash

export CONFIG_PATH="${CONFIG_PATH:-/home/rclone/.config/rclone/rclone.conf}"

export RCLONE_BACKEND_PASS="${OVERRIDE_RCLONE_BACKEND_PASS:-password}"
export RCLONE_BACKEND_PATH="${OVERRIDE_RCLONE_BACKEND_PATH:-/}"
export RCLONE_BACKEND_OPTIONS=("${OVERRIDE_OPTIONS}")

if [ -f "${CONFIG_PATH}" ]; then
        if [ -n "${RCLONE_BACKEND}" ] && [ -n "${RCLONE_BACKEND_PROTOCOL}" ];then
                exec "$@"
        else
                exit 1
        fi
else
        echo "Config does not exist, please create config first"
        exit 1
fi
