terraform {
  backend "gcs" {
    bucket  = "devops-tf-state-ak-001"
    prefix = "gcp/dev"
  }
}
