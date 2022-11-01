##########
# Provider
##########

provider "google" {
  project = var.project_id
  region  = var.region
  zone    = var.zone
}

######################################
# Terraform resource + remote backend
######################################

terraform {
  required_providers {
    google = {
      source  = "hashicorp/google"
      version = ">= 4.0.0"
    }
  }

  backend "gcs" {
    bucket = "bucket-tfstate-accel-finops-df-22"
    prefix = "terraform/state"
  }
}

# To bring terraform state bucket under terraform management,
# uncomment this resource and use
# terraform import google_storage_bucket.bucket-tfstate <bucket name in gcs backend in terraform resource>
#resource "google_storage_bucket" "bucket-tfstate" {
#  name          = "bucket-tfstate-${var.project_id}"
#  location      = var.state_location
#  storage_class = "STANDARD"
#  versioning {
#    enabled = true
#  }
#}
