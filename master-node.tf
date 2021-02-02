resource "google_compute_instance" "k8s-master" {

  count                     = 1
  project                   = var.project_id

  name         = "k8s-master"
  machine_type = var.machine_type
  zone         = var.zone
  connection {
    host = var.master_ip
  }

  boot_disk {
    initialize_params {
      image = var.instances_os
    }
  }

  network_interface {
    network            = local.vpc_network_id
    subnetwork         = local.vpc_network_subnet_id
    network_ip         = var.master_ip
    subnetwork_project = var.project_id
  }

  metadata_startup_script = var.startup_script_master
}