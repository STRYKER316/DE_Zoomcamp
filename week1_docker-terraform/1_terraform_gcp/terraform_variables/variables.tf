variable "credentials" {
  description = "My Credentials"
  default     = "../keys/my_creds.json"
  #   ex: if you have a sibling directory called keys, with your service account json file saved there as my-creds.json,
  #   you could use default = "../keys/my-creds.json"
}


variable "project" {
  description = "Project ID"
  default     = "algebraic-argon-414214"
}

variable "region" {
  description = "Region"
  #   Update the below to your desired region
  default = "asia-south1"
}

variable "location" {
  description = "Project Location"
  #   Update the below to your desired location
  default = "asia-south1"
}

variable "bq_dataset_name" {
  description = "My BigQuery Dataset Name"
  #   Update the below to what you want your dataset to be called
  default = "demo_dataset_2"
}

variable "gcs_bucket_name" {
  description = "My Storage Bucket Name"
  #   Update the below to a unique bucket name
  default = "algebraic-argon-414214-terra-bucket-2"
}

variable "gcs_storage_class" {
  description = "Bucket Storage Class"
  default     = "STANDARD"
}