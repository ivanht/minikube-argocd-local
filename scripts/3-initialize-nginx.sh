#!/bin/bash

echo "This script is for documentation purposes only."
echo "The files have already been generated."
echo "If you want to run it, remove the next 2 lines in the script."
sleep 10
exit 0

# Create base directory structure
mkdir -p gitops/nginx/
helm repo add bitnami https://charts.bitnami.com/bitnami
helm repo update
helm pull bitnami/nginx --version 20.0.5 --destination gitops/nginx/charts

cd gitops/nginx/charts
tar -xzf nginx-20.0.5.tgz
rm -rf nginx-20.0.5.tgz
mv nginx/* ./
rm -rf nginx/

# Create single Helm values file
cat >> gitops/nginx/charts/custom-values.yaml << 'EOF'
service:
  type: NodePort

serverBlock: |-
  server {
    listen 0.0.0.0:8080;
    server_name _;
    root /usr/share/nginx/html;
    index index.html;
    location / {
      return 200 'hello it\'s me';
      add_header Content-Type text/plain;
    }
  }

EOF

# Create ArgoCD applications
cat > gitops/nginx/nginx-staging-app.yaml << 'EOF'
apiVersion: argoproj.io/v1alpha1
kind: Application
metadata:
  name: nginx-staging
  namespace: argocd
spec:
  project: default
  source:
    repoURL: https://github.com/ivanht/minikube-argocd-local.git
    targetRevision: HEAD
    path: gitops/nginx/charts/
    helm:
      valueFiles:
        - ../custom-values.yaml
  destination:
    server: https://kubernetes.default.svc
    namespace: external-staging
  syncPolicy:
    automated:
      prune: true
      selfHeal: true
EOF

cat > gitops/nginx/nginx-production-app.yaml << 'EOF'
apiVersion: argoproj.io/v1alpha1
kind: Application
metadata:
  name: nginx-production
  namespace: argocd
spec:
  project: default
  source:
    repoURL: https://github.com/ivanht/minikube-argocd-local.git
    targetRevision: HEAD
    path: gitops/nginx/charts/
    helm:
      valueFiles:
        - ../custom-values.yaml
  destination:
    server: https://kubernetes.default.svc
    namespace: external-production
  syncPolicy:
    syncOptions:
      - ManualSync=true
EOF
