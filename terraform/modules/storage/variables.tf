variable "environment" {
  type        = string
  description = "Environment name"
  default     = "dev"
}

variable "region" {
  type        = string
  description = "GCP region"
}

variable "iam_members" {
  description = "List of IAM members for the bucket"
  type        = list(string)
  default = [
    "user:user@example.com",
    "serviceAccount:example@project-id.iam.gserviceaccount.com"
  ]
}