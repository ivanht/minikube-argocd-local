#!/bin/bash

helm repo add grafana https://grafana.github.io/helm-charts
helm repo add prometheus-community https://prometheus-community.github.io/helm-charts
helm repo update

# Create namespace for monitoring
kubectl create namespace monitoring


# Install Loki, Prometheus, and Grafana
helm install loki grafana/loki-stack
helm install kube-prometheus-stack prometheus-community/kube-prometheus-stack -n monitoring

