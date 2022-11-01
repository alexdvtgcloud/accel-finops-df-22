# Enable IAM API
resource "google_project_service" "iam" {
  service            = "iam.googleapis.com"
  disable_on_destroy = false
}

# Enable Artifact Registry API
resource "google_project_service" "artifactregistry" {
  service            = "artifactregistry.googleapis.com"
  disable_on_destroy = false
}

# Enable Cloud Run API
resource "google_project_service" "cloudrun" {
  service            = "run.googleapis.com"
  disable_on_destroy = false
}

# Enable Cloud Build API
resource "google_project_service" "cloudbuild" {
  service            = "cloudbuild.googleapis.com"
  disable_on_destroy = false
}

# Enable App Engine API
resource "google_project_service" "appengine" {
  service            = "appengine.googleapis.com"
  disable_on_destroy = false
}

# Enable Firestore API
resource "google_project_service" "firestore" {
  service            = "firestore.googleapis.com"
  disable_on_destroy = false
}