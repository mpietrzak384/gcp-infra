variable "gcp_project_id" {
  description = "Project ID in GCP"
  type        = string
}

variable "default_zone" {
  description = "Default zone"
  type        = string
}

variable "environment" {
  description = "Environment name (e.g., dev, prod)"
  type        = string
}

variable "region" {
  description = "Region where resources will be deployed"
  type        = string
}

variable "zones" {
  description = "List of zones for the Compute Engine instances"
  type        = list(string)
}

variable "db_user" {
  description = "Database username for the application"
  type        = string
}

variable "db_password" {
  description = "Database password for the application"
  type        = string
  sensitive   = true
}
