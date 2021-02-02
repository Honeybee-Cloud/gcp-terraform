#Taken from https://github.com/searce-engineering/terraform-k8s-gce
#No license given

#Variables.tf

variable project_id {
  description = "GCP based self managed K8s cluster."
  default     = "honeybee-hive"
}

variable cluster_name {
  description = "The cluster name that is to be set for the cluster"
  default     = "honeybee-hive-test"
}

variable master_ip {
  description = "IP of the master server"
  default     = "10.128.0.19"
}

variable subnet_range {
  description = "Subnet range"
  default     = "10.128.0.0/24"
}

variable subnet_name {
  description = "Name of the subnet"
  default     = "k8s-nodes-subnet"
}

variable network_name {
  description = "Name of the network"
  default     = "k8s-vpc"
}

variable k8s_version {
  description = "The Version of kubernetes to be installed on the cluster"
  default     = "1.11.8"
}

# This is for SSH (22) and Kube Proxy (8080)
variable ssh_source_ranges {
  description = "Network ranges to allow SSH from"
  type        = "list"
  default     = []
}

variable cloud_provider {
  description = "Underlying cloud provider: AWS, GCP, Azure"
  default     = "GCP"
}

variable region {
  description = "The region in which the cluster should be deployed"
  default     = "us-central1"
}

variable zone {
  description = "The zone in which the cluster should be deployed"
  default     = "us-central1-c"
}

variable pod_network_type {
  description = "The pod network type to be set for the clusters"
  default     = "calico"
}

variable calico_version {
  description = "The calico version to be installed on cluster"
  default     = "3.5"
}

variable google_apis_url {
  description = "The google apis url"
  default     = "https://content.googleapis.com/compute/v1/projects"
}

variable startup_script_master {
  description = "The startup script to run on the master"
  default     = "sudo apt update && sudo apt install git ansible; sudo ansible-playbook k8s-master-playbook.yml"
}

variable startup_script_worker {
  description = "The startup script to run on the workers"
  default     = "sudo apt update && sudo apt install git ansible; sudo ansible-playbook k8s-node-playbook.yml"
}

variable num_workers {
  default     = 3
}

variable access_config {
  default     = []
}