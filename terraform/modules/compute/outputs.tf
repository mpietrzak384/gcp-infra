output "igm_name" {
  description = "Name of the instance group manager"
  value       = google_compute_region_instance_group_manager.web_igm.name
}

output "http_lb_ip" {
  description = "IP address of the global HTTP Load Balancer"
  # If not reserving a separate address, the forwarding_rule self_link includes one
  value = google_compute_global_forwarding_rule.web_http_forwarding_rule.ip_address
}
