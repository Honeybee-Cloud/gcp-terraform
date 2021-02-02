terraform {
  required_providers {
    google = {
      source = "hashicorp/google"
      version = "3.5.0"
    }
  }
}

provider "google" {

  credentials = file(var.creds_path)

  project = var.project_id
  region  = var.region
  zone    = var.zone
}

resource "google_compute_subnetwork" "vpc_network_subnet" {
  name          = var.subnet_name
  ip_cidr_range = var.subnet_range
  region        = var.region
  network       = google_compute_network.vpc_network.id
}

resource "google_compute_network" "vpc_network" {
  name = var.network_name
  auto_create_subnetworks = false
}

locals {
  vpc_network_id = google_compute_network.vpc_network.id
  vpc_network_subnet_id = google_compute_subnetwork.vpc_network_subnet.id
}