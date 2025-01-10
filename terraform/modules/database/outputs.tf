output "instance_connection_name" {
  description = "Cloud SQL instance connection name"
  value       = google_sql_database_instance.db_instance.connection_name
}

output "db_private_ip" {
  description = "Private IP of the Cloud SQL instance"
  value       = google_sql_database_instance.db_instance.private_ip_address
}

output "db_password_secret_version" {
  description = "The versioned secret containing the DB password"
  value       = google_secret_manager_secret_version.db_password_version.name
}
