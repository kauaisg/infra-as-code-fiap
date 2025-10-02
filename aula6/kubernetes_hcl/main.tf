# kubernetes_hcl/main.tf
resource "kubernetes_namespace" "ns" {
  metadata { name = var.namespace }
}

resource "kubernetes_config_map" "app_config" {
  metadata { name = "app-config" namespace = kubernetes_namespace.ns.metadata[0].name }
  data = { APP_ENV = "staging", LOG_LVL = "info" }
}

resource "kubernetes_secret" "db_secret" {
  metadata { name = "db-credentials" namespace = kubernetes_namespace.ns.metadata[0].name }
  data = { username = base64encode("admin"), password = base64encode("supersecret") }
  type = "Opaque"
}

resource "kubernetes_deployment" "nginx" {
  metadata { name = "nginx-deploy" namespace = kubernetes_namespace.ns.metadata[0].name labels = { app = "nginx" } }
  spec {
    replicas = var.replicas
    selector { match_labels = { app = "nginx" } }
    template {
      metadata { labels = { app = "nginx" } }
      spec {
        container {
          name  = "nginx"
          image = var.image
          port { container_port = 80 }
          env {
            name = "APP_ENV"
            value_from {
              config_map_key_ref { name = kubernetes_config_map.app_config.metadata[0].name key = "APP_ENV" }
            }
          }
        }
      }
    }
  }
}

resource "kubernetes_role" "read_pods" {
  metadata { name = "read-pods" namespace = kubernetes_namespace.ns.metadata[0].name }
  rule { api_groups = [""] resources = ["pods"] verbs = ["get","list"] }
}

resource "kubernetes_role_binding" "bind_read_pods" {
  metadata { name = "bind-read-pods" namespace = kubernetes_namespace.ns.metadata[0].name }
  role_ref { api_group = "rbac.authorization.k8s.io" kind = "Role" name = kubernetes_role.read_pods.metadata[0].name }
  subject { kind = "User" name = "demo-user" api_group = "rbac.authorization.k8s.io" }
}
