#!/bin/bash
set -e

# Start Jenkins in background
exec /usr/bin/tini -- /usr/local/bin/jenkins.sh
