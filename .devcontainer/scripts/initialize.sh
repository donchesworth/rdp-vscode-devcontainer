#!/usr/bin/env bash

for i in $(ls); do
    if [ -f "${i}/requirements.txt" ]; then
        cp ${i}/requirements.txt .devcontainer/requirements/${i}requirements.txt
        echo "${i}/requirements.txt copied"
    fi
done

osascript -e 'tell application "Viscosity" to connect "Red Hat Global VPN"'
