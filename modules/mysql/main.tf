locals {
  secret_name = "database-secret"
  namespace = "lamp-stack"
}

resource "kubernetes_deployment" "mysql" {
  metadata {
    namespace = local.namespace
    name   = var.deployment_def.name
    labels = var.deployment_def.labels
  }

  spec {
    replicas = 3
    selector {
      match_labels = var.deployment_def.labels
    }
    template {
      metadata {
        labels = var.deployment_def.labels
        name   = var.deployment_def.name
      }
      spec {

        container {
          name  = var.deployment_def.container_name
          image = var.deployment_def.image
          volume_mount {
            name = "my-pv-storage"
            mount_path = "/var/lib/mysql"
          }
          env {
            name = "MYSQL_ROOT_PASSWORD"
            value_from {
              secret_key_ref {
                name = local.secret_name
                key  = "mysql_root_password"
              }
            }

          }
          env {
            name = "MYSQL_USER"
            value_from {
              secret_key_ref {
                name = local.secret_name
                key  = "mysql_user"
              }
            }

          }

          env {
            name = "MYSQL_PASSWORD"
            value_from {
              secret_key_ref {
                name = local.secret_name
                key  = "mysql_password"
              }
            }

          }

          env {
            name = "MYSQL_DATABASE"
            value_from {
              secret_key_ref {
                name = local.secret_name
                key  = "mysql_database"
              }
            }

          }
          env {
            name = "PMA_HOST"
            value_from {
              secret_key_ref {
                name = local.secret_name
                key  = "pma_host"
              }
            }

          }
          port {
            container_port = 3306
          }
        }
        volume {
          name = "my-pv-storage"
          persistent_volume_claim {
            claim_name = "database-volume-claim"
          }
        }
      }
      
    }
  }
}


resource "kubernetes_service" "mysql" {
  metadata {
    namespace = local.namespace
    name   = var.service_def.name
    labels = var.deployment_def.labels
  }
  spec {
    selector = var.deployment_def.labels
    port {
      protocol = "TCP"
      port     = 3306
    }
    type = var.service_def.type
  }

}

output "database_ip" {
  value = kubernetes_service.mysql.spec[0].cluster_ip
}
