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
  name          = "algebraic-argon-414214-terra-bucket"
  location      = "ASIA"
  force_destroy = true

  lifecycle_rule {
    condition {
      age = 1
    }
    action {
      type = "AbortIncompleteMultipartUpload"
    }
  }
}