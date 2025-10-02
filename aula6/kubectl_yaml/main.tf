# kubectl_yaml/main.tf
variable "namespace" { description = "Namespace alvo" type = string default = "demo" }

resource "kubectl_manifest" "svc" {
  yaml_body = file("${path.module}/manifests/service.yaml")
}

resource "kubectl_manifest" "ingress" {
  yaml_body   = file("${path.module}/manifests/ingress.yaml")
  depends_on  = [kubectl_manifest.svc]
}
