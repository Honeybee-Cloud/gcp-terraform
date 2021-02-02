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
  description = "IP range of the subnet"
  default     = "10.240.0.0/24"
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

variable network {
  description = "The network the cluster is to to be deployed into"
  default     = "default"
}

variable google_apis_url {
  description = "The google apis url"
  default     = "https://content.googleapis.com/compute/v1/projects"
}

variable startup_script {
  default     = "sudo apt update && sudo apt install git ansible; sudo ansible-playbook k8s-node-playbook.yml"
}
