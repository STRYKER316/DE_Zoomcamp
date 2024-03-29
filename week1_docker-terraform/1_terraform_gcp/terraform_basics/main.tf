terraform {
  required_providers {
    google = {
      source  = "hashicorp/google"
      version = "5.16.0"
    }
  }
}


provider "google" {
  # credentials only needs to be set, if you do not have the GOOGLE_CREDENTIALS set in the enviornment as -> [export GOOGLE_CREDENTIALS='<path-of-creds.json>']
  # credentials = 
  project = "algebraic-argon-414214"
  region  = "asia-south1"
}


resource "google_storage_bucket" "demo-bucket-1" {
  name     = "algebraic-argon-414214-terra-bucket-1"
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


resource "google_bigquery_dataset" "demo-dataset-1" {
  dataset_id = "demo_dataset_1"
  location   = "asia-south1"
}