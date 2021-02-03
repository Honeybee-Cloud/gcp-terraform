locals { timestamp = regex_replace(timestamp(), "[- TZ:]", "") }

source "googlecompute" "honeybee-k8s-master-vm" {
  project_id      = "honeybee-hive"
  source_image    = "ubuntu-os-cloud"
  source_family   = "ubuntu-2004-lts"
  ssh_username    = "honeybee"
  zone            = "us-central1-c"
  machine_type    = "f1-micro"
  # startup_script_file = ""
}

build {
  sources = ["sources.googlecompute.honeybee-k8s-master-vm"]

  # FROM: https://learn.hashicorp.com/tutorials/packer/getting-started-provision?in=packer/getting-started
  # Note: The sleep 30 in the example above is very important. Because Packer is 
  # able to detect and SSH into the instance as soon as SSH is available, Ubuntu
  # actually doesn't get proper amount of time to initialize. The sleep makes 
  # sure that the OS properly initializes.
  provisioner "shell" {
    inline = [
      "sleep 30",
      "sudo apt-get update",
      "sudo apt-get install -y git ansible apt-transport-https ca-certificates curl gnupg-agent software-properties-common"
    ]
  }

  provisioner "ansible-local": [
    {
      playbook_files     = ["./k8s-master-playbook.yml", "./k8s-base-playbook.yml"]
    }
  ]
}