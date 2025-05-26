# Create the storage pool
resource "libvirt_pool" "kvm" {
  name = "my-kvm-pool"
  type = "dir"
  target {
    path = var.libvirt_disk_path
  }
}

#### create storage volume 
##resource "libvirt_volume" "os_image" {
##  name   = "${var.hostname}-os_image.qcow2"
##  pool   = libvirt_pool.kvm.name
##  source = var.os_img-url
##  #format = "qcow2"
##}
#
# Create the storage volume
resource "libvirt_volume" "os_image" {
  count  = var.vm_count
  name   = "${var.hostname}-${count.index + 1}.qcow2"
  pool   = libvirt_pool.kvm.name
  source = "${var.os_img-url}"
  format = "qcow2"
}
#
#
### Manages a cloud-init ISO disk that can be used to customize a domain during first boot.
##resource "libvirt_cloudinit_disk" "commoninit" {
##  name           = "${var.hostname}-commoninit.qcow2"
##  pool           = libvirt_pool.kvm.name
##  user_data      = data.template_cloudinit_config.config.rendered
###  network_config = data.template_file.network_config.rendered
##}
#
# Manages a cloud-init ISO disk that can be used to customize a domain during first boot.
resource "libvirt_cloudinit_disk" "cloudinit_disk" {
  count = var.vm_count
  name = "${var.hostname}-${count.index + 1}-cloudinit.iso"

  pool = libvirt_pool.kvm.name

  user_data = data.template_cloudinit_config.config[count.index].rendered
}
