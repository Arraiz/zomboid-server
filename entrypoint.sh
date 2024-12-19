#!/bin/bash
set -e

# Install/update the server if not already installed
if [ ! -f "${HOME}/serverfiles/ProjectZomboid64.json" ]; then
    ./pzserver install
else
    ./pzserver update
fi

# Start the server
exec ./pzserver start-dev 