provider "google" {
  project = var.project
}

resource "google_storage_bucket" "sample_bucket" {

  name                        = "${var.project}-sample-bucket"
  location                    = var.region
  storage_class               = "STANDARD"
  uniform_bucket_level_access = true

  labels = {
    env = "playpen"
  }

  versioning {
    enabled = true
  }
}

resource "google_project_service" "cloud_sql_service" {
  service = "sqladmin.googleapis.com"
  depends_on = [
    google_project_service.cloud_manager
  ]
}

resource "google_project_service" "cloud_manager" {
  service = "cloudresourcemanager.googleapis.com"
}

resource "google_sql_database" "database" {
  name     = "${var.project}-cloudy-database"
  instance = google_sql_database_instance.instance.name
}

resource "google_sql_database_instance" "instance" {
  name             = "${var.project}-cloudy-database-instance"
  database_version = "POSTGRES_11"
  region           = var.region
  settings {
    tier = "db-f1-micro"
  }

  deletion_protection = "false"

  depends_on = [
    google_project_service.cloud_sql_service
  ]
}
