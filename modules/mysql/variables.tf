variable "deployment_def" {
  type = object({
    name = string
    labels = object({
      app     = string
      creator = string
    })
    image          = string
    container_name = string
  })
  default = {
    container_name = "mysql-database"
    labels = {
      app     = "database"
      creator = "rashid"
    }
    image = "mysql"
    name  = "mysql-database"
  }
}


variable "service_def" {
  type = object({
    name = string
    type = string
  })
  default = {
    name = "mysql-database"
    type = "ClusterIP"
  }
}
