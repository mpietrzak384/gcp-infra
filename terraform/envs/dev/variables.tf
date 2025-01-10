variable "environment" {
  type    = string
  default = "dev"
}

variable "machine_type" {
  type    = string
  default = "e2-medium"
}

variable "source_image" {
  type    = string
  default = "ubuntu-os-cloud/ubuntu-2004-lts"
}

variable "database_version" {
  type    = string
  default = "MYSQL_8_0"
}

variable "db_tier" {
  type    = string
  default = "db-f1-micro"
}

variable "db_name" {
  type    = string
  default = "app_db"
}

variable "db_user" {
  type    = string
  default = "app_user"
}

variable "db_password" {
  type = string
}

variable "zones" {
  type    = list(string)
  default = ["europe-central2-a", "europe-central2-b"]
}

variable "min_replicas" {
  type    = number
  default = 1
}

variable "max_replicas" {
  type    = number
  default = 3
}

variable "cpu_utilization_target" {
  type    = number
  default = 0.6
}
