resource "google_compute_network" "main_vpc" {
  name                    = "${var.environment}-main-vpc"
  auto_create_subnetworks = false
  description             = "VPC for ${var.environment} environment"
}

resource "google_compute_subnetwork" "main_subnet" {
  name          = "${var.environment}-subnet"
  ip_cidr_range = var.main_subnet_cidr_range
  network       = google_compute_network.main_vpc.self_link
  region        = var.region
}

resource "google_compute_firewall" "allow_http" {
  name    = "${var.environment}-allow-http"
  network = google_compute_network.main_vpc.self_link

  allow {
    protocol = "tcp"
    ports    = ["80"]
  }

  source_ranges = var.trusted_ranges
  log_config {
    metadata = "INCLUDE_ALL_METADATA"
  }
  description = "Allow HTTP from trusted sources"
}

resource "google_compute_firewall" "allow_https" {
  name    = "${var.environment}-allow-https"
  network = google_compute_network.main_vpc.self_link

  allow {
    protocol = "tcp"
    ports    = ["443"]
  }

  source_ranges = var.trusted_ranges
  log_config {
    metadata = "INCLUDE_ALL_METADATA"
  }
  description = "Allow HTTPS from trusted sources"
}
