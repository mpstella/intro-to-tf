output "connection_name" {
  value = google_sql_database_instance.instance.connection_name
}

output "bucket_url" {
  value = google_storage_bucket.sample_bucket.url
}
