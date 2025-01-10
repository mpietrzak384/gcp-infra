resource "random_id" "rand_suffix" {
  byte_length = 2
}

resource "google_storage_bucket" "app_bucket" {
  name          = "${var.environment}-app-bucket-${random_id.rand_suffix.hex}"
  location      = var.region
  force_destroy = true

  versioning {
    enabled = true
  }

  lifecycle_rule {
    action {
      type          = "SetStorageClass"
      storage_class = "NEARLINE"
    }
    condition {
      age = 30
    }
  }

  uniform_bucket_level_access = true
  public_access_prevention    = "enforced"

  logging {
    log_bucket        = var.logging_bucket_name
    log_object_prefix = "logs/"
  }
}

resource "google_storage_bucket_iam_binding" "app_bucket_iam_binding" {
  bucket  = google_storage_bucket.app_bucket.name
  role    = "roles/storage.objectViewer"
  members = var.iam_members
}