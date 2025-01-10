resource "google_sql_database_instance" "db_instance" {
  name             = "${var.environment}-sql"
  database_version = var.database_version
  region           = var.region

  settings {
    tier              = var.db_tier
    availability_type = "REGIONAL"

    backup_configuration {
      enabled = true
    }

    ip_configuration {
      ipv4_enabled    = false
      private_network = var.private_network
      require_ssl     = true
    }

    disk_autoresize = true
    disk_size       = var.disk_size
    disk_type       = var.disk_type
  }

  deletion_protection = var.deletion_protection
}

resource "google_sql_database" "application_db" {
  name     = var.db_name
  instance = google_sql_database_instance.db_instance.name
}

resource "google_sql_user" "default_user" {
  name     = var.db_user
  instance = google_sql_database_instance.db_instance.name
  password = var.db_password
}

resource "google_secret_manager_secret" "db_password_secret" {
  secret_id = "${var.environment}-db-password"

  replication {
    auto {}
  }
}

resource "google_secret_manager_secret_version" "db_password_version" {
  secret = google_secret_manager_secret.db_password_secret.name

  secret_data     = var.db_password
  deletion_policy = "DISABLE"
}
