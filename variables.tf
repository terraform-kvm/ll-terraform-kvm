
variable "libvirt_disk_path" {
  description = "path for libvirt pool"
  default     = "/data/domain"
}

variable "os_img-url" {
  description = "Your OS image file path"
  default     = "/data/vm-domain/kvm-node1/alma-project/AlmaLinux-9-GenericCloud-latest.x86_64.qcow2"
}

variable "username" {
  description = "username for ssh"
  default     = "almalinux"
  #default     = "redhat"
}

variable "hostname" {
  #default     = "rhel8"
  default = "alma9"
  description = "domain name in libvirt, not hostname"
}

variable "os_type_ci" {
  #default = "redhat8"
  default = "alma9"
}

variable "domain" {
  default = "example.com"
}
variable "ssh_path" {
  description = "Path to SSH key directory"
  default     = "/home/llops/.ssh/id_rsa.pub" # no trailing slash
}
#variable "ip_type" {
  #default = "static"
#}

variable "memoryMB" {
  default = 1024 * 1
}

variable "cpu" {
  default = 1
}

variable "vm_domain_name" {
  default = "alma9"
  #default = "rhel8"
}

variable "terraform_network" {
  default = "network"
}
variable "network_range" {
  description = "IP range for network"
  type        = list(string)
  default     = ["192.168.100.0/24"]
}

variable "vm_count" {
  default = 1
}
variable "libvirt_provider" {
  default = "qemu+ssh://llops@kvm-node1/system?keyfile=/home/llops/.ssh/id_rsa"
}
variable "static_ips" {
  default = ["192.168.100.60", "192.168.100.61", "192.168.100.63"]
  type        = list(string)
}
