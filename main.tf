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

  project = "honeybee-hive"
  region  = "us-central1"
  zone    = "us-central1-c"
     
  source                 = "./modules/gcp"
  instance_admin         = "admin"
  instance_admin_pass    = "supersecretpassword"
  gcp_instance_name      = "k8s-node-01"
  gcp_instance_os        = "ubuntu-2004-lts"
  ssh_key_path           = "~/.ssh/"
  ssh_key_pub            = "id_rsa.pub"
  ssh_key_priv           = "id_rsa"
  ssh_user               = "lwilson2048@gmail.com"
}

resource "google_compute_firewall" "default-firewall" {
  name    = "k8s-firewall-ingress"
  network = google_compute_network.vpc_network.name

  allow {
    protocol = "tcp"
  }
  allow {
    protocol = "udp"
  }
  allow {
    protocol = "icmp"
  }
  allow {
    protocol = "ipip"
  }

  direction = "INGRESS"
  source_ranges = [ "10.240.0.0/24" ]
}

resource "google_compute_firewall" "default-firewall" {
  name    = "k8s-firewall-egress"
  network = google_compute_network.vpc_network.name

  allow {
    protocol = "tcp"
    pports = [ "6443" ]
  }
  allow {
    protocol = "tcp"
    pports = [ "22" ]
  }
  allow {
    protocol = "icmp"
  }

  direction = "EGRESS"
  source_ranges = [ "0.0.0.0/0" ]
}

resource "google_compute_subnetwork" "vpc_network_subnet" {
  name          = "k8s-nodes-subnet"
  ip_cidr_range = "10.240.0.0/24"
  region        = "us-central1"
  network       = google_compute_network.vpc_network.id
}

resource "google_compute_network" "vpc_network" {
  name = "k8s-vpc"
  auto_create_subnetworks = false
}

provisioner "remote-exec" {
    connection { 
        type    = "ssh"
        user    = "${var.ssh_user}"
        timeout = "500s"
        private_key = "${file("${var.ssh_key_path}${var.ssh_key_priv}")}"
    }
    inline = [
        "sudo apt update && sudo apt install git ansible",
        "sudo ansible-playbook ansible-install.yml"
    ]
}