resource "google_compute_instance" "k8s-master" {

  count                     = "1"
  project                   = "${var.project}"

  name         = "${var.name}"
  machine_type = "${var.machine_type}"
  zone         = "${var.zone}"

  network_interface {
    network            = "${var.network_name}"
    subnetwork         = "${var.subnet_name}"
    access_config      = ["${var.access_config}"]
    network_ip         = "${var.master_ip}"
    subnetwork_project = "${var.project}"
  }

  metadata_startup_script = "${var.startup_script_master}"
}