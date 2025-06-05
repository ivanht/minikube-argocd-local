terraform {
  required_providers {
    kubernetes = {
      source = "hashicorp/kubernetes"
      version = "~> 2.0"
    }
    helm = {
      source  = "hashicorp/helm"
      version = "3.0.0-pre2"
    }
  }
}

provider "kubernetes" {
  config_path    = "~/.kube/config"
  config_context = "minikube"
}

provider "helm" {
  kubernetes = {
    config_path    = "~/.kube/config"
    config_context = "minikube"
  }
}