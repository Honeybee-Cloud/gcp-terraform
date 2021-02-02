resource "google_compute_instance" "k8s-worker" {
  count       = var.num_workers
  project     = "${var.project}"

  machine_type = "${var.machine_type}"

  region = "${var.region}"

  network_interface {
    network            = "${var.network_name}"
    subnetwork         = "${var.subnet_name}"
    access_config      = ["${var.access_config}"]
    subnetwork_project = "${var.project}"
  }

  disk {
    auto_delete  = "${var.disk_auto_delete}"
    boot         = true
    source_image = "${var.compute_image}"
    type         = "PERSISTENT"
    disk_type    = "${var.disk_type}"
    disk_size_gb = "${var.disk_size_gb}"
    mode         = "${var.mode}"
  }
  
  metadata_startup_script = "${var.startup_script_worker}"
}
