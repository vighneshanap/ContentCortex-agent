terraform {
  backend "gcs" {
    bucket = "qwiklabs-gcp-03-aac323e581e2-terraform-state"
    prefix = "ContentCortex-agent/prod"
  }
}
