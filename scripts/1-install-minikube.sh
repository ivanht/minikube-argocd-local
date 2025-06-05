#!/bin/bash

function continue_or_exit() {
    read -p "Do you want to continue? (y/n): " CONTINUE
    if [ "$CONTINUE" != "y" ]; then
        echo "Exiting..."
        sleep 10
        exit 1
    fi
}

function check_status_and_exit() {
    if [ $? -ne 0 ]; then
        echo "Error: $1"
        echo "Exiting..."
        echo "Please check the error message and try again."
        sleep 10
        exit 1
    fi
}

echo "This script only works on macOS with docker installed"
continue_or_exit

# Check if running on macOS
if [[ "$OSTYPE" != "darwin"* ]]; then
    echo "This script is only for macOS"
    exit 1
fi
# Check if Docker is installed and running
echo "Checking if Docker is installed and running..."
if ! command -v docker &> /dev/null; then
    echo "Error: Docker is not installed"
    echo "Please install Docker Desktop for Mac first"
    exit 1
fi

# Check if Docker daemon is running
if ! docker info &> /dev/null; then
    echo "Error: Docker daemon is not running"
    echo "Please start Docker Desktop and try again"
    exit 1
fi

echo "Docker is installed and running"


echo "Installing Homebrew... if not installed. If you don't type 'y', script will exit."
continue_or_exit

# Check if Homebrew is installed
if ! command -v brew &> /dev/null; then
    echo "Installing Homebrew..."
    /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
else
    echo "Homebrew is already installed"
fi

echo "Installing Minikube ... If you don't type 'y', script will exit."
continue_or_exit
# Install hyperkit and minikube
echo "Installing minikube..."
if ! command -v minikube &> /dev/null; then
    brew install minikube
    check_status_and_exit
else
    echo "Minikube is already installed"
fi

# Start minikube
echo "Starting minikube..."
if minikube status | grep -q "Running"; then
    echo "Minikube is already running"
else
    minikube start --driver=docker
    check_status_and_exit
fi
# Verify installation
echo "Verifying minikube installation..."
minikube status
check_status_and_exit
echo "Minikube installation complete!"
minikube tunnel &
echo "Minikube tunnel running!"