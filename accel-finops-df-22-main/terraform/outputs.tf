output "cloud_run_service_url" {
  description = "The public URL of the Cloud Run service"
  value       = google_cloud_run_service.run_service.status[0].url
}