variable "project_id" {
  default = "adelin-bobocea-sandbox1"
}

variable "region" {
  default = "europe-west1"
}

variable "zone" {
  default = "europe-west1-b"
}

# https://cloud.google.com/firestore/docs/locations
variable "firestore_location" {
  description = "Location of Firestore database"
  default     = "europe-west3"
}

variable "state_location" {
  description = "Location of Terraform state bucket"
  default     = "europe"
}

variable "docker_repository" {
  description = "The name of the Artifact Registry repository to be created."
  default     = "docker-repository"
}

variable "docker_image" {
  description = "The name of the Docker image in the Artifact Registry repository to be deployed to Cloud Run."
  default     = "budgets-app-image"
}

variable "app_name" {
  default = "budgets-app"
}
