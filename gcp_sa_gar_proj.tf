resource "google_service_account" "service_account" {
  project = "fine-effect-382702"
  account_id   = "project-sa"
  display_name = "SA for Project"
}

resource "google_artifact_registry_repository" "my-project-repo" {
  project = "fine-effect-382702"
  location      = "us-central1"
  repository_id = "proj-store-app-repo"
  format        = "DOCKER"
}