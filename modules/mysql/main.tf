resource "kubernetes_deployment" "mysql" {
  metadata {
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

          port {
            container_port = 3306
          }
        }
      }
    }
  }
}


resource "kubernetes_service" "mysql" {
  metadata {
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
