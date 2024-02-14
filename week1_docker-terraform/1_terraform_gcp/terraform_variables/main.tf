terraform {
  required_providers {
    google = {
      source  = "hashicorp/google"
      version = "5.16.0"
    }
  }
}


provider "google" {
  credentials = file(var.credentials)
  project     = var.project
  region      = var.region
}


resource "google_storage_bucket" "demo-bucket-2" {
  name     = var.gcs_bucket_name
  location = var.location

  # Optional, but recommended settings:
  storage_class               = var.gcs_storage_class
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

  lifecycle_rule {
    condition {
      age = 1 // days
    }
    action {
      type = "AbortIncompleteMultipartUpload"
    }
  }

  force_destroy = true
}


resource "google_bigquery_dataset" "demo-dataset-2" {
  dataset_id = var.bq_dataset_name
  location   = var.location
}