resource "google_service_account" "service_account" {
  project      = "fine-effect-382702"
  account_id   = "project-sa"
  display_name = "SA for Project"
}

resource "google_project_iam_member" "github_token_creator" {
  project = "fine-effect-382702"
  role    = "roles/iam.serviceAccountTokenCreator"
  member  = "serviceAccount:${google_service_account.service_account.email}"
}

resource "google_project_iam_member" "github_act_as" {
  project = "fine-effect-382702"
  role    = "roles/artifactregistry.writer"
  member  = "serviceAccount:${google_service_account.service_account.email}"
}

# resource "google_project_iam_member" "github_act_as" {
#   project = "fine-effect-382702"
#   role    = "roles/artifactregistry.repositories.create"
#   member  = "serviceAccount:${google_service_account.service_account.email}"
# }

resource "google_artifact_registry_repository" "my-project-repo" {
  project       = "fine-effect-382702"
  location      = "us-central1"
  repository_id = "proj-store-app-repo"
  format        = "DOCKER"
}

resource "google_artifact_registry_repository" "helm_charts" {
  project = "fine-effect-382702"
  repository_id = "helm-charts-repo"
  format        = "DOCKER"
  location      = "us-central1"
}

resource "google_project_iam_binding" "helm_charts_iam" {
  project = "fine-effect-382702"
  
  role = "roles/artifactregistry.admin"

  members = [
   # List of members who will have the create repository role
   "user:erkin.bektenov@fulbrightmail.org",
   "serviceAccount:project-sa@fine-effect-382702.iam.gserviceaccount.com"
   # Add more members as needed
  ]
}
