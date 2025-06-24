#!/bin/sh

echo "Starting backup..."
rcon-cli "say Starting backup..."
sleep 10
rcon-cli "save-off"
rcon-cli "save-all"
sleep 10
