locals {
  namespace   = "lamp-stack"
  secret_name = "database-secret"
}

resource "kubernetes_deployment" "phpmyadminapache" {
  metadata {
    name      = "phpmyadminapache-deployment"
    namespace = local.namespace
  }
  spec {
    replicas = 2
    selector {
      match_labels = var.deployment_def.labels
    }
    template {
      metadata {
        labels = var.deployment_def.labels
      }
      spec {
        container {
          name  = var.deployment_def.name
          image = var.deployment_def.image

           env {
            name = "PMA_USER"
            value_from {
              secret_key_ref {
                name = local.secret_name
                key  = "mysql_user"
              }
            }

          }

          env {
            name = "PMA_PASSWORD"
            value_from {
              secret_key_ref {
                name = local.secret_name
                key  = "mysql_password"
              }
            }

          }

          env {
            name  = "PMA_PORT"
            value = "3306"
          }
          env {
            name  = "PMA_HOST"
            value = "mysql-database"
          }

          port {
            container_port = 80
          }
        }
      }
    }
  }
}

resource "kubernetes_service" "phpmyadminapache" {
  depends_on = [kubernetes_deployment.phpmyadminapache]
  metadata {
    name      = var.service_def.name
    namespace = local.namespace
  }
  spec {
    selector = var.deployment_def.labels
    port {
      protocol  = "TCP"
      port      = 80
      node_port = var.service_def.node_port
    }
    type = var.service_def.type
  }
}
