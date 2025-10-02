# Exemplo de RBAC - princípio do menor privilégio
# Este Role permite apenas listar e obter informações de pods dentro do namespace demo

resource "kubernetes_role" "read_pods" {
  metadata {
    name      = "read-pods"
    namespace = kubernetes_namespace.demo.metadata[0].name
  }

  rule {
    api_groups = [""]
    resources  = ["pods"]
    verbs      = ["get", "list"]
  }
}

# RoleBinding associa o Role ao usuário "demo-user"
resource "kubernetes_role_binding" "read_pods_binding" {
  metadata {
    name      = "read-pods-binding"
    namespace = kubernetes_namespace.demo.metadata[0].name
  }

  role_ref {
    api_group = "rbac.authorization.k8s.io"
    kind      = "Role"
    name      = kubernetes_role.read_pods.metadata[0].name
  }

  subject {
    kind      = "User"
    name      = "demo-user" # substitua pelo usuário ou service account real do seu cluster
    api_group = "rbac.authorization.k8s.io"
  }
}
