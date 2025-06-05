#!/bin/bash

# Execute installation scripts in order
echo "================================================"
echo "Starting installation process..."
echo "================================================"

# Run minikube installation script
echo "================================================"
echo "Step 1: Installing Minikube and dependencies..."
echo "================================================"
./scripts/1-install-minikube.sh
sleep 10

# Run terraform script
echo "================================================"
echo "Step 2: Setting up infrastructure with Terraform..."
echo "================================================"
./scripts/2-run-terraform.sh
sleep 10

# Run nginx initialization script
echo "================================================"
echo "Step 3: Deploying NGINX configuration..."
echo "================================================"
./scripts/4-deploy-nginx.sh
sleep 10

echo "================================================"
echo "Installation complete!"
echo "================================================"


