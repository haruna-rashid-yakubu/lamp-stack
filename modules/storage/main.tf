# Ressource physique 
resource "kubernetes_persistent_volume" "database_volume" {
  metadata {
    name = "database-volume"
  }

  spec {
    access_modes = ["ReadWriteOnce"]
    persistent_volume_source {
      host_path {
        path = "/data"
      }
    }
    capacity = {
      "storage" = "2Gi"
    }
    volume_mode        = "Filesystem"
    storage_class_name = "database-volume"
  }
}
# moyen d'acces a la ressource physique 
resource "kubernetes_persistent_volume_claim" "name" {
  metadata {
    name      = "database-volume-claim"
    namespace = "lamp-stack"
  }
  spec {
    storage_class_name = "database-volume"
    access_modes = ["ReadWriteOnce"]
    resources {
      requests = {
        "storage" = "1Gi"
      }
    }
  }
}
