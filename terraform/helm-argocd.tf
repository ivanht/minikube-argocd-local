

resource "kubernetes_namespace" "argocd" {
  metadata {
    name = "argocd"
  }
}

resource "helm_release" "argocd" {
  name       = "argocd"
  repository = "https://argoproj.github.io/argo-helm"
  chart      = "argo-cd"
  version    = "5.46.7"
  namespace  = kubernetes_namespace.argocd.metadata[0].name

  values = [
    <<-EOT
    server:
      extraArgs:
        - --insecure
      service:
        type: LoadBalancer
    EOT
  ]

  depends_on = [kubernetes_namespace.argocd]
}
