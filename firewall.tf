resource "google_compute_firewall" "k8s-firewall-ingress" {
  name    = "k8s-firewall-ingress"
  network = google_compute_network.vpc_network.name

  allow {
    protocol = "tcp"
  }
  allow {
    protocol = "udp"
  }
  allow {
    protocol = "icmp"
  }
  allow {
    protocol = "ipip"
  }

  direction = "INGRESS"
  source_ranges = [ "10.240.0.0/24" ]
}

resource "google_compute_firewall" "k8s-firewall-egress" {
  name    = "k8s-firewall-egress"
  network = google_compute_network.vpc_network.name

  allow {
    protocol = "tcp"
    pports = [ "6443" ]
  }
  allow {
    protocol = "tcp"
    pports = [ "22" ]
  }
  allow {
    protocol = "icmp"
  }

  direction = "EGRESS"
  source_ranges = [ "0.0.0.0/0" ]
}