#!/bin/bash
set -e  # Stop script on error

# Define variables
GIT_REPO="https://github.com/ragothamang/sel-in-jenkins-docker-container-2025.git"
WORK_DIR="/var/jenkins_home/workspace/automation-suite"

# Ensure workspace directory exists
mkdir -p $WORK_DIR
chown -R jenkins:jenkins /var/jenkins_home

# Clone the repository at runtime (if not already cloned)
if [ ! -d "$WORK_DIR/.git" ]; then
    echo "Cloning repository..."
    git clone $GIT_REPO $WORK_DIR
else
    echo "Repository already exists. Pulling latest changes..."
    cd $WORK_DIR && git pull
fi

# Start Jenkins
exec /usr/bin/tini -- /usr/local/bin/jenkins.sh
