output "service_ip" {
  value =  kubernetes_service.apache.spec[0].cluster_ip
}