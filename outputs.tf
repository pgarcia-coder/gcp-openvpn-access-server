locals {
  instance_ip = google_compute_instance.instance.network_interface[0].access_config[0].nat_ip
}

output "site_url" {
  description = "Site Url"
  value       = "https://${local.instance_ip}:443/"
}

output "admin_url" {
  description = "Admin Url"
  value       = "https://${local.instance_ip}:943/admin"
}

output "admin_user" {
  description = "Username for Admin password."
  value       = "openvpn"
}

output "admin_password" {
  description = "Password for Admin."
  value       = var.admin_password
  sensitive   = true
}

output "instance_self_link" {
  description = "Self-link for the compute instance."
  value       = google_compute_instance.instance.self_link
}

output "instance_zone" {
  description = "Zone for the compute instance."
  value       = var.zone
}

output "instance_machine_type" {
  description = "Machine type for the compute instance."
  value       = var.machine_type
}

output "instance_nat_ip" {
  description = "External IP of the compute instance."
  value       = local.instance_ip
}

output "instance_network" {
  description = "Self-link for the network of the compute instance."
  value       = google_compute_network.vpc_network.id
}
