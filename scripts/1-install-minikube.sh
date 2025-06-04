#!/bin/bash

function continue_or_exit() {
    read -p "Do you want to continue? (y/n): " CONTINUE
    if [ "$CONTINUE" != "y" ]; then
        echo "Exiting..."
        exit 1
    fi
}

echo "This script only works on macOS"
continue_or_exit

# Check if running on macOS
if [[ "$OSTYPE" != "darwin"* ]]; then
    echo "This script is only for macOS"
    exit 1
fi

echo "Installing Homebrew... if not installed. If you don't type 'y', script will exit."
continue_or_exit

# Check if Homebrew is installed
if ! command -v brew &> /dev/null; then
    echo "Installing Homebrew..."
    /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
else
    echo "Homebrew is already installed"
fi

echo "Installing Minikube and Hyperkit... If you don't type 'y', script will exit."
continue_or_exit
# Install hyperkit and minikube
echo "Installing hyperkit and minikube..."
brew install hyperkit 
brew install minikube 

# Start minikube
echo "Starting minikube..."
minikube start --driver=hyperkit

# Verify installation
echo "Verifying minikube installation..."
minikube status
echo "Minikube installation complete!"

# Install Helm
echo "Installing Helm... If you don't type 'y', script will exit."
continue_or_exit
echo "Installing Helm..."
brew install helm

# Verify Helm installation
echo "Verifying Helm installation..."
helm version

# Install kubectl
echo "Installing kubectl... If you don't type 'y', script will exit."
continue_or_exit
echo "Installing kubectl..."
brew install kubectl

# Verify kubectl installation
echo "Verifying kubectl installation..."
kubectl version --client
