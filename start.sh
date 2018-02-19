#!/bin/bash

# Slightly modified version of NatTuck's
# https://github.com/NatTuck/memory/blob/master/start.sh

export PORT=5200

cd ~/www/tasktracker
./bin/tasktracker stop || true
./bin/tasktracker start

