resource "google_compute_instance" "k8s-master" {

  count                     = 1
  project                   = var.project_id

  name         = "k8s-master"
  machine_type = var.machine_type
  zone         = var.zone

  boot_disk {
    initialize_params {
      image = var.instances_os
    }
  }

  network_interface {
    access_config {
      nat_ip = var.access_config
    }
    network            = var.network_name
    subnetwork         = var.subnet_name
    network_ip         = var.master_ip
    subnetwork_project = var.project_id
  }

  metadata_startup_script = var.startup_script_master
}