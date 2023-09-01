variable "database_secret" {
  type = object({
    name = string
    type = string
    data = object({
      mysql_root_password = string
      mysql_user          = string
      mysql_password      = string
      pma_host            = string
      mysql_database      = string
    })
  })
  default = {
    name = "database-secret"
    type = "Opaque"
    data = {
      mysql_database      = "my-database"
      mysql_user          = "rashid"
      mysql_root_password = "root"
      mysql_password      = "rashid"
      pma_host            = "rashid"
    }
  }
}
