variable "environment" {
  type        = string
  description = "Environment name"
  default     = "dev"
}

variable "vpc_self_link" {
  type        = string
  description = "VPC self_link"
}

variable "subnet_self_link" {
  type        = string
  description = "Subnetwork self_link"
}

variable "machine_type" {
  type        = string
  description = "Compute Engine machine type"
  default     = "e2-medium"
}

variable "source_image" {
  type        = string
  description = "Source image for the instance template"
  default     = "ubuntu-os-cloud/ubuntu-2004-lts"
}

variable "region" {
  type        = string
  description = "GCP region"
}

variable "zones" {
  type        = list(string)
  description = "List of zones to distribute MIG across"
  default     = ["europe-central2-a", "europe-central2-b"]
}

variable "min_replicas" {
  type        = number
  description = "Minimum number of instances in the group"
  default     = 1
}

variable "max_replicas" {
  type        = number
  description = "Maximum number of instances in the group"
  default     = 3
}

variable "cpu_utilization_target" {
  type        = number
  description = "Target CPU utilization for autoscaling"
  default     = 0.6
}
