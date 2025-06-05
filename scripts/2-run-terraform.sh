#!/bin/bash

# Change to terraform directory relative to script location
cd terraform


# Only download ArgoCD chart if it doesn't exist
if [ ! -f "charts/argo-cd-8.0.14.tgz" ]; then
    # Create charts directory if it doesn't exist
    mkdir -p charts/
    echo "Downloading ArgoCD chart..."
    helm repo add argo https://argoproj.github.io/argo-helm
    helm repo update
    helm pull argo/argo-cd --version 8.0.14 --destination charts/
else
    echo "ArgoCD chart already exists, skipping download."
fi

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

# let's enable port forwarding for argocd
echo "Enabling port forwarding for ArgoCD..."
echo "Run on a new terminal: $ kubectl port-forward svc/argocd-server 8080:80 -n argocd"

echo "--------------------------------"
echo "Once above command executed, you can access ArgoCD at https://localhost:8080"
echo "Username: admin"
echo "Password: $(kubectl -n argocd get secret argocd-initial-admin-secret -o jsonpath="{.data.password}" | base64 -d)"
echo "--------------------------------"

sleep 10
