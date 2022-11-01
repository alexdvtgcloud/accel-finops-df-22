#####################
# Artifact Registry #
#####################

# Create Artifact Registry repository for Docker containers
resource "google_artifact_registry_repository" "docker_repo" {
  location      = var.region
  repository_id = var.docker_repository
  format        = "DOCKER"
  depends_on    = [google_project_service.artifactregistry]
}

#############
# Firestore #
#############

# Create Firestore, through the creation of an App Engine application
# https://cloud.google.com/firestore/docs/solutions/automate-database-create#create_a_database_with_terraform
resource "google_app_engine_application" "app" {
  project       = var.project_id
  location_id   = var.firestore_location
  database_type = "CLOUD_FIRESTORE"
  depends_on = [google_project_service.appengine, google_project_service.firestore]
}


#############
# Cloud Run #
#############

# Create Cloud Run service
resource "google_cloud_run_service" "run_service" {
  name     = var.app_name
  location = var.region

  template {
    spec {
      containers {
        image = "${var.region}-docker.pkg.dev/${var.project_id}/${var.docker_repository}/${var.docker_image}"
      }
    }
  }

  traffic {
    percent         = 100
    latest_revision = true
  }

  depends_on = [google_artifact_registry_repository.docker_repo, google_project_service.cloudrun]
}

# Apply policy binding to Cloud Run Service to allow unauthenticated invocations from all users
resource "google_cloud_run_service_iam_binding" "iam_allow_unauthenticated" {
  location = var.region
  project  = var.project_id
  service  = google_cloud_run_service.run_service.name
  role     = "roles/run.invoker"
  members = [
    "allUsers",
  ]
  depends_on = [google_project_service.iam]
}
