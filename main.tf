terraform {
  required_providers {
    kubernetes = {
      source = "kubernetes"
    }
  }
  backend "kubernetes" {
    config_path   = "~/.kube/config"
    secret_suffix = "lamp-stack"
  }
}

locals {
  namespace = "lamp-stack"
}

provider "kubernetes" {
  config_path = "~/.kube/config"
}
#  Creation du namespace de la stack LAMP
resource "kubernetes_namespace" "lamp-ns" {
  metadata {
    name = "lamp-stack"
  }
}

module "data" {
  source = "./modules/data"
}

module "apache" {
  depends_on = [module.data, module.mysql]
  source     = "./modules/apache"
}

module "mysql" {
  source     = "./modules/mysql"
  depends_on = [module.data]
}

module "php" {
  source     = "./modules/php"
  depends_on = [module.data, module.mysql]
}

