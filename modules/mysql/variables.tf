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
    container_name = "mysql"
    labels = {
      app     = "database"
      creator = "rashid"
    }
    image = "mysql"
    name  = "mysql"
  }
}


variable "service_def" {
  type = object({
    name      = string
    type      = string
  })
  default = {
    name = "mysql"
    type = "ClusterIP"
  }
}