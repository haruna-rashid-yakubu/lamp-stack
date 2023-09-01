locals {
  namespace = "lamp-stack"
}

resource "kubernetes_secret" "database_secret" {
  metadata {
    name      = var.database_secret.name
    namespace = local.namespace
  }
  type = var.database_secret.type
  data = var.database_secret.data
}

