# kubernetes_hcl/main.tf
resource "kubernetes_namespace" "ns" {
  metadata {
    name = var.namespace
  }
}

resource "kubernetes_config_map" "app_config" {
  metadata {
    name      = "app-config"
    namespace = kubernetes_namespace.ns.metadata[0].name
  }
  data = {
    APP_ENV = "staging"
    LOG_LVL = "info"
  }
}

resource "kubernetes_secret" "db_secret" {
  metadata {
    name      = "db-credentials"
    namespace = kubernetes_namespace.ns.metadata[0].name
  }
  data = {
    username = base64encode(var.db_user)
    password = base64encode(var.db_password)
  }
  type = "Opaque"
}

resource "kubernetes_deployment" "nginx" {
  metadata {
    name      = "nginx-deploy"
    namespace = kubernetes_namespace.ns.metadata[0].name
    labels = {
      app = "nginx"
    }
  }
  spec {
    replicas = var.replicas
    selector {
      match_labels = {
        app = "nginx"
      }
    }
    template {
      metadata {
        labels = {
          app = "nginx"
        }
      }
      spec {
        container {
          name  = "nginx"
          image = var.image
          port {
            container_port = 80
          }
          env {
            name = "APP_ENV"
            value_from {
              config_map_key_ref {
                name = kubernetes_config_map.app_config.metadata[0].name
                key  = "APP_ENV"
              }
            }
          }
        }
      }
    }
  }
}

