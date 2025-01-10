variable "environment" {
  type        = string
  description = "Environment name"
  default     = "dev"
}

variable "database_version" {
  type        = string
  description = "DB version to use e.g. MYSQL_8_0, POSTGRES_14"
  default     = "MYSQL_8_0"
}

variable "region" {
  type        = string
  description = "GCP region"
}

variable "db_tier" {
  type        = string
  description = "SQL tier e.g. db-f1-micro, db-g1-small, db-n1-standard-1"
  default     = "db-f1-micro"
}

variable "db_name" {
  type        = string
  description = "Name of the initial database"
  default     = "app_db"
}

variable "db_user" {
  type        = string
  description = "default DB username"
  default     = "app_user"
}

variable "db_password" {
  type        = string
  description = "default DB user passowrd"
  sensitive   = true
}

variable "private_network" {
  type        = string
  description = "Self link of private network for DB instance"
}

variable "disk_size" {
  type        = number
  description = "The size of the disk in GB"
  default     = 10
}

variable "disk_type" {
  type        = string
  description = "The type of the disk e.g. PD_SSD, PD_HDD"
  default     = "PD_SSD"
}

variable "deletion_protection" {
  type        = bool
  description = "Enable deletion protection for the DB"
  default     = true
}
