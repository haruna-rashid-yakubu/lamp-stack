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
    container_name = "php-my-admin"
    labels = {
      app     = "phpserver"
      creator = "rashid"
    }
    image = "phpmyadmin"
    name  = "phpmyadmin"
  }
}


variable "service_def" {
  type = object({
    name      = string
    type      = string
    node_port = number
  })
  default = {
    name      = "phpmyadmin"
    type      = "NodePort"
    node_port = 31800
  }
}
