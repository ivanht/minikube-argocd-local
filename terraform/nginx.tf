

resource "helm_release" "nginx" {
  name       = "nginx"
  repository = "https://charts.bitnami.com/bitnami"
  chart      = "nginx"
  version    = "20.0.5"
  namespace  = kubernetes_namespace.external.metadata[0].name

  values = [
    <<-EOT
    service:
      type: LoadBalancer
    serverBlock: |-
      server {
        listen 0.0.0.0:8080;
        location / {
          return 200 'hello it\'s me';
          add_header Content-Type text/plain;
        }
      }
    EOT
  ]

  depends_on = [kubernetes_namespace.external]
}
