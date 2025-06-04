resource "kubernetes_namespace" "external-production" {
  metadata {
    name = "external-production"
  }
}

resource "kubernetes_namespace" "internal-production" {
  metadata {
    name = "internal-production"
  }
}

resource "kubernetes_namespace" "external-staging" {
  metadata {
    name = "external-staging"
  }
}

resource "kubernetes_namespace" "internal-staging" {
  metadata {
    name = "internal-staging"
  }
}