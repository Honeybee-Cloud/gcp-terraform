terraform {
  required_providers {
    google = {
      source = "hashicorp/google"
      version = "3.5.0"
    }
  }
}

provider "google" {

  credentials = file("credentials/credentials.json")

  project = "${var.project-id}"
  region  = "${var.region}"
  zone    = "${var.zone}"
     
  instance_admin         = "admin"
  instance_admin_pass    = "supersecretpassword"
  gcp_instance_name      = "k8s-node-01"
  gcp_instance_os        = "ubuntu-2004-lts"
  ssh_key_path           = "~/.ssh/"
  ssh_key_pub            = "id_rsa.pub"
  ssh_key_priv           = "id_rsa"
  ssh_user               = "lwilson2048@gmail.com"
}

resource "google_project" "project" {
  name            = "Honeybee"
  project_id      = random_id.id.hex
  billing_account = var.billing_account
  org_id          = var.org_id
}

resource "google_compute_subnetwork" "vpc_network_subnet" {
  name          = "k8s-nodes-subnet"
  ip_cidr_range = "${var.subnet_range}"
  region        = "${var.region}"
  network       = google_compute_network.vpc_network.id
}

resource "google_compute_network" "vpc_network" {
  name = "k8s-vpc"
  auto_create_subnetworks = false
}