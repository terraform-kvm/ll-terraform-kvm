# Create a network for the VMs
resource "libvirt_network" "terraform_network" {
  name = "network"
  mode = "nat"
  addresses = var.network_range
  dhcp {
    enabled = true
    }
  dns {
    enabled = true
  }
  autostart = true
}
