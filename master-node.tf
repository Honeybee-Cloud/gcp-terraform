resource "google_compute_instance" "k8s-master" {

  count                     = "1"
  project                   = "${var.project}"

  name         = "${var.name}"
  machine_type = "${var.machine_type}"
  zone         = "${var.zone}"

  network_interface {
    network            = "${var.subnetwork == "" ? var.network : ""}"
    subnetwork         = "${var.subnetwork}"
    access_config      = ["${var.access_config}"]
    network_ip         = "${var.network_ip}"
    subnetwork_project = "${var.subnetwork_project == "" ? var.project : var.subnetwork_project}"
  }

  # metadata_startup_script = "echo hi > /test.txt"

  service_account {
    email  = "${var.service_account_email}"
    scopes = ["${var.service_account_scopes}"]
  }

  metadata_startup_script = "${var.startup_script}"
}