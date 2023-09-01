locals {
  namespace = "lamp-stack"
}

resource "kubernetes_deployment" "apache" {
  metadata {
    name      = "apache-deployment"
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
          port {
            container_port = 80
          }
        }
      }
    }
  }
}

resource "kubernetes_service" "apache" {
  depends_on = [kubernetes_deployment.apache]
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
