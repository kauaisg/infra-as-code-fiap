# kubernetes_hcl/outputs.tf
output "namespace" { value = var.namespace }
output "deployment_name" { value = kubernetes_deployment.nginx.metadata[0].name }
output "configmap_name" { value = kubernetes_config_map.app_config.metadata[0].name }
output "secret_name" { value = kubernetes_secret.db_secret.metadata[0].name }
