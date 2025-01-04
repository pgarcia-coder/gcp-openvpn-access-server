provider "google" {
  project = var.project_id
}

locals {
  metadata = {
    admin_pw                 = var.admin_password
    google-logging-enable    = "0"
    google-monitoring-enable = "0"
  }
}

resource "google_compute_network" "vpc_network" {
  name = var.network
}

resource "google_compute_subnetwork" "subnetwork" {
  name          = var.sub_network
  ip_cidr_range = var.sub_network_ip_cidr_range
  region        = var.region
  network       = google_compute_network.vpc_network.id
}

resource "google_compute_address" "global_ip" {
  name         = "${var.goog_cm_deployment_name}-global-ip"
  address_type = "EXTERNAL"
  region       = var.region
}

resource "google_service_account" "service_account" {
  account_id   = "${var.goog_cm_deployment_name}-sa"
  display_name = "${var.goog_cm_deployment_name}-sa"
}

resource "google_project_iam_member" "service_account_roles" {
  for_each = toset([
    "roles/config.agent",
    "roles/compute.admin",
    "roles/iam.serviceAccountUser"
  ])

  project = var.project_id
  member  = "serviceAccount:${google_service_account.service_account.email}"
  role    = each.value
}


resource "google_compute_instance" "instance" {
  name         = "${var.goog_cm_deployment_name}-vm"
  machine_type = var.machine_type
  zone         = var.zone

  tags = ["${var.goog_cm_deployment_name}-deployment"]

  boot_disk {
    device_name = "autogen-vm-tmpl-boot-disk"

    initialize_params {
      size  = var.boot_disk_size
      type  = var.boot_disk_type
      image = var.source_image
    }
  }

  can_ip_forward = var.ip_forward

  metadata = local.metadata

  network_interface {
    network    = google_compute_network.vpc_network.id
    subnetwork = google_compute_subnetwork.subnetwork.id

    access_config {
      nat_ip = google_compute_address.global_ip.address
    }
  }

  service_account {
    email = google_service_account.service_account.email
    scopes = compact([
      "https://www.googleapis.com/auth/cloud.useraccounts.readonly",
      "https://www.googleapis.com/auth/devstorage.read_only",
      "https://www.googleapis.com/auth/logging.write",
      "https://www.googleapis.com/auth/monitoring.write"
    ])
  }
}

resource "google_compute_firewall" "tcp_443" {
  count = var.enable_tcp_443 ? 1 : 0

  name    = "${var.goog_cm_deployment_name}-tcp-443"
  network = google_compute_network.vpc_network.id

  allow {
    ports    = ["443"]
    protocol = "tcp"
  }

  source_ranges = compact([for range in split(",", var.tcp_443_source_ranges) : trimspace(range)])

  target_tags = ["${var.goog_cm_deployment_name}-deployment"]
}

resource "google_compute_firewall" "tcp_943" {
  count = var.enable_tcp_943 ? 1 : 0

  name    = "${var.goog_cm_deployment_name}-tcp-943"
  network = google_compute_network.vpc_network.id

  allow {
    ports    = ["943"]
    protocol = "tcp"
  }

  source_ranges = compact([for range in split(",", var.tcp_943_source_ranges) : trimspace(range)])

  target_tags = ["${var.goog_cm_deployment_name}-deployment"]
}

resource "google_compute_firewall" "udp_1194" {
  count = var.enable_udp_1194 ? 1 : 0

  name    = "${var.goog_cm_deployment_name}-udp-1194"
  network = google_compute_network.vpc_network.id

  allow {
    ports    = ["1194"]
    protocol = "udp"
  }

  source_ranges = compact([for range in split(",", var.udp_1194_source_ranges) : trimspace(range)])

  target_tags = ["${var.goog_cm_deployment_name}-deployment"]
}

resource "google_compute_firewall" "tcp_945" {
  count = var.enable_tcp_945 ? 1 : 0

  name    = "${var.goog_cm_deployment_name}-tcp-945"
  network = google_compute_network.vpc_network.id

  allow {
    ports    = ["945"]
    protocol = "tcp"
  }

  source_ranges = compact([for range in split(",", var.tcp_945_source_ranges) : trimspace(range)])

  target_tags = ["${var.goog_cm_deployment_name}-deployment"]
}

resource "google_compute_firewall" "tcp_22" {
  count = var.enable_tcp_22 ? 1 : 0

  name    = "${var.goog_cm_deployment_name}-tcp-22"
  network = google_compute_network.vpc_network.id

  allow {
    ports    = ["22"]
    protocol = "tcp"
  }

  source_ranges = compact([for range in split(",", var.tcp_22_source_ranges) : trimspace(range)])

  target_tags = ["${var.goog_cm_deployment_name}-deployment"]
}
