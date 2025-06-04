#!/bin/bash

# Apply ArgoCD applications
kubectl apply -f gitops/nginx/nginx-staging-app.yaml
kubectl apply -f gitops/nginx/nginx-production-app.yaml

