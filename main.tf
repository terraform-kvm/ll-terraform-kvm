

#resource "libvirt_volume" "alma9-qcow2" {
#  name   = "alma9.qcow2"
#  pool   = libvirt_pool.kvm.name
#  source = var.os_img-url
#  #format = "qcow2"
#}

# Manages a VM domain resource within libvirt
#resource "libvirt_domain" "default_domain" {
#  name   = var.vm_domain_name
#  memory = var.memoryMB
#  vcpu   = var.cpu
#
#  cpu {
#    mode = "host-passthrough"
#  }
#
#  disk {
#    volume_id = libvirt_volume.os_image.id
#  }
#
#  network_interface {
#    network_name   = var.terraform_network
#    addresses = ["192.168.100.60"]
#
#  }
#
#  cloudinit = libvirt_cloudinit_disk.commoninit.id
#
#}


resource "libvirt_domain" "default_domain" {
  count  = var.vm_count
  name   = "${var.vm_domain_name}-${count.index + 1}"
  memory = var.memoryMB
  vcpu   = var.cpu
  
  graphics {
    type        = "vnc"
    listen_type = "none"
  }
  cpu {
    mode = "host-passthrough"
  }

  disk {
    volume_id = libvirt_volume.os_image[count.index].id
  }

  network_interface {
    network_name = var.terraform_network
  }

  cloudinit = libvirt_cloudinit_disk.cloudinit_disk[count.index].id
}
