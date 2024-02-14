terraform {
  required_providers {
    google = {
      source  = "hashicorp/google"
      version = "5.16.0"
    }
  }
}

provider "google" {
  project = "algebraic-argon-414214"
  region  = "asia-south1"
}

resource "google_storage_bucket" "demo-bucket" {
  name     = "algebraic-argon-414214-terra-bucket"
  location = "ASIA"

  # Optional, but recommended settings:
  storage_class               = "STANDARD"
  uniform_bucket_level_access = true

  versioning {
    enabled = true
  }

  lifecycle_rule {
    action {
      type = "Delete"
    }
    condition {
      age = 30 // days
    }
  }

  force_destroy = true
}