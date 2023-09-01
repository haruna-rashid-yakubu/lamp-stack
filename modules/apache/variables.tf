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
    container_name = "apache"
    labels = {
      app     = "webserver"
      creator = "rashid"
    }
    image = "httpd"
    name  = "apache"
  }
}


variable "service_def" {
  type = object({
    name      = string
    type      = string
    node_port = number
  })
  default = {
    name = "apache"
    type = "NodePort"
    node_port = 31700
  }
}
