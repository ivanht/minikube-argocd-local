resource "kubernetes_namespace" "argocd" {
  metadata {
    name = "argocd"
  }
}

resource "helm_release" "argocd" {
  name       = "argocd"
  chart      = "./charts/argo-cd-8.0.14.tgz"
  namespace  = kubernetes_namespace.argocd.metadata[0].name

  depends_on = [kubernetes_namespace.argocd]
}
