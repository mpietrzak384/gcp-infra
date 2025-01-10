variable "environment" {
  type        = string
  description = "Environment name"
  default     = "dev"
}

variable "main_subnet_cidr_range" {
  type    = string
  default = "10.0.0.0/16"
}

variable "region" {
  type        = string
  description = "Region for the subnetwork"
}

variable "trusted_ranges" {
  type        = list(string)
  description = "List of trusted IP ranges for firewall rules"
  default     = ["0.0.0.0/0"] # replace with actual trusted ranges for production
}
