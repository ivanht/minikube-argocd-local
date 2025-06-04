#!/bin/bash

cd terraform

# Initialize Terraform
echo "Initializing Terraform..."
terraform init

# Plan Terraform changes
echo "Planning Terraform changes..."
terraform plan

# Apply Terraform changes
echo "Applying Terraform changes..."
terraform apply -auto-approve

cd ..

echo "Terraform setup complete!"
