resource "google_compute_instance" "k8s-worker" {
  count       = var.num_workers
  project     = var.project_id
  name        = "k8s-worker"

  machine_type = var.machine_type
  zone = var.zone

  provisioner "file" {
    source      = "./k8s-base-playbook.yml"
    destination = "/root/k8s-base-playbook.yml"
  }

  provisioner "file" {
    source      = "./k8s-node-playbook.yml"
    destination = "/root/k8s-node-playbook.yml"
  }

  boot_disk {
    initialize_params {
      image = var.instances_os
    }
  }

  network_interface {
    network            = var.network_name
    subnetwork         = var.subnet_name
    subnetwork_project = var.project_id
  }

  metadata_startup_script = var.startup_script_worker
}
