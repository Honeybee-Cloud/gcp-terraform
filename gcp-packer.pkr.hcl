locals { timestamp = regex_replace(timestamp(), "[- TZ:]", "") }

source "googlecompute" "honeybee-k8s-vm" {
  project_id      = "honeybee-hive"
  source_image    = "cos-77-12371-1109-0"
  ssh_username    = "honeybee"
  zone            = "us-central1-c"
  machine_type    = "f1-micro"
}

build {
  sources = ["sources.googlecompute.honeybee-k8s-master-vm"]
}