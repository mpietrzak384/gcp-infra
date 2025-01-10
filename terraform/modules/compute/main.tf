resource "google_compute_instance_template" "web_template" {
  name_prefix  = "${var.environment}-web-"
  machine_type = var.machine_type

  disk {
    source_image = var.source_image
    auto_delete  = true
    boot         = true
  }

  network_interface {
    network    = var.vpc_self_link
    subnetwork = var.subnet_self_link
  }

  metadata_startup_script = file("${path.module}/../../scripts/startup.sh")

  tags = ["nginx"]

  metadata = {
    block-project-ssh-keys = "true"
  }

  shielded_instance_config {
    enable_secure_boot          = true
    enable_vtpm                 = true
    enable_integrity_monitoring = true
  }
}

resource "google_compute_region_instance_group_manager" "web_igm" {
  name                      = "${var.environment}-web-igm"
  base_instance_name        = "${var.environment}-web"
  region                    = var.region
  distribution_policy_zones = var.zones

  version {
    instance_template = google_compute_instance_template.web_template.self_link
    name              = "primary"
  }

  target_size = var.min_replicas

  auto_healing_policies {
    health_check      = google_compute_health_check.web_health_check.self_link
    initial_delay_sec = 300
  }
}

resource "google_compute_autoscaler" "web_autoscaler" {
  name   = "${var.environment}-web-autoscaler"
  target = google_compute_region_instance_group_manager.web_igm.self_link

  autoscaling_policy {
    min_replicas = var.min_replicas
    max_replicas = var.max_replicas
    cpu_utilization {
      target = var.cpu_utilization_target
    }
  }
}

resource "google_compute_health_check" "web_health_check" {
  name               = "${var.environment}-health-check"
  check_interval_sec = 5
  timeout_sec        = 5
  http_health_check {
    request_path = "/"
    port         = 80
  }
  healthy_threshold   = 2
  unhealthy_threshold = 2
}

resource "google_compute_backend_service" "web_backend" {
  name          = "${var.environment}-web-backend"
  protocol      = "HTTP"
  health_checks = [google_compute_health_check.web_health_check.self_link]
  timeout_sec   = 30

  backend {
    group = google_compute_region_instance_group_manager.web_igm.instance_group
  }

  connection_draining_timeout_sec = 10
  load_balancing_scheme           = "EXTERNAL"
}

resource "google_compute_url_map" "web_url_map" {
  name            = "${var.environment}-web-url-map"
  default_service = google_compute_backend_service.web_backend.self_link
}

resource "google_compute_target_http_proxy" "web_http_proxy" {
  name    = "${var.environment}-web-http-proxy"
  url_map = google_compute_url_map.web_url_map.self_link
}

resource "google_compute_global_forwarding_rule" "web_http_forwarding_rule" {
  name        = "${var.environment}-http-forwarding-rule"
  ip_protocol = "TCP"
  port_range  = "80"
  target      = google_compute_target_http_proxy.web_http_proxy.self_link
}

resource "google_compute_global_address" "web_lb_ip" {
  name = "${var.environment}-web-lb-ip"
}