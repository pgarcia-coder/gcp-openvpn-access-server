variable "project_id" {
  description = "The ID of the project in which to provision resources."
  type        = string
}

variable "region" {
  description = "The region in which to provision resources."
  type        = string
}

variable "zone" {
  description = "The zone for the solution to be deployed."
  type        = string
}

variable "goog_cm_deployment_name" {
  description = "The name of the deployment and VM instance."
  type        = string
}

variable "network" {
  description = "The network name to attach the VM instance."
  type        = string
}

variable "sub_network" {
  description = "The sub network name to attach the VM instance."
  type        = string
}

variable "admin_password" {
  description = "The password for the admin user."
  type        = string
  sensitive   = true
}

variable "sub_network_ip_cidr_range" {
  description = "The IP CIDR range for the sub network."
  type        = string
  default     = "10.0.0.0/16"
}

variable "source_image" {
  description = "The image name for the disk for the VM instance."
  type        = string
  default     = "projects/mpi-openvpn-access-server-2008/global/images/aspub2131-20240822"
}

variable "machine_type" {
  description = "The machine type to create, e.g. e2-small"
  type        = string
  default     = "e2-medium"
}

variable "boot_disk_type" {
  description = "The boot disk type for the VM instance."
  type        = string
  default     = "pd-balanced"
}

variable "boot_disk_size" {
  description = "The boot disk size for the VM instance in GBs"
  type        = number
  default     = 20
}

variable "ip_forward" {
  description = "Whether to allow sending and receiving of packets with non-matching source or destination IPs."
  type        = bool
  default     = false
}

variable "enable_tcp_443" {
  description = "Allow HTTPS traffic from the Internet"
  type        = bool
  default     = true
}

variable "tcp_443_source_ranges" {
  description = "Source IP ranges for HTTPS traffic"
  type        = string
  default     = ""
}

variable "enable_tcp_943" {
  description = "Allow TCP port 943 traffic from the Internet"
  type        = bool
  default     = true
}

variable "tcp_943_source_ranges" {
  description = "Source IP ranges for TCP port 943 traffic"
  type        = string
  default     = ""
}

variable "enable_udp_1194" {
  description = "Allow UDP port 1194 traffic from the Internet"
  type        = bool
  default     = true
}

variable "udp_1194_source_ranges" {
  description = "Source IP ranges for UDP port 1194 traffic"
  type        = string
  default     = ""
}

variable "enable_tcp_945" {
  description = "Allow TCP port 945 traffic from the Internet"
  type        = bool
  default     = true
}

variable "tcp_945_source_ranges" {
  description = "Source IP ranges for TCP port 945 traffic"
  type        = string
  default     = ""
}

variable "enable_tcp_22" {
  description = "Allow TCP port 22 traffic from the Internet"
  type        = bool
  default     = true
}

variable "tcp_22_source_ranges" {
  description = "Source IP ranges for TCP port 22 traffic"
  type        = string
  default     = ""
}
