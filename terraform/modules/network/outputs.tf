output "vpc_self_link" {
  description = "Self link of the created VPC"
  value       = google_compute_network.main_vpc.self_link
}

output "subnet_self_link" {
  description = "Self link of the created Subnet"
  value       = google_compute_subnetwork.main_subnet.self_link
}

output "subnet_name" {
  description = "Name of the created Subnet"
  value       = google_compute_subnetwork.main_subnet.name
}
