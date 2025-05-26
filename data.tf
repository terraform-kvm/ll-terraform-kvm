data "template_file" "user_data" {
  count    = var.vm_count
  template = file("${path.module}/cloud-init/${var.os_type_ci}_init.cfg")
  vars = {
    hostname   = "${var.hostname}-${count.index + 1}"
    fqdn       = "${var.hostname}-${count.index + 1}.${var.domain}"
    public_key = file("${var.ssh_path}")
  }
}

# Save the result as init.cfg
data "template_cloudinit_config" "config" {
  count          = var.vm_count
  gzip          = false
  base64_encode = false
  part {
    filename     = "init.cfg"
    content_type = "text/cloud-config"
    content      = data.template_file.user_data[count.index].rendered
  }
}

## collect cloudinit network data
#data "template_file" "network_config" {
#  template = file("${path.module}/cloud-init/network_config_${var.ip_type}.cfg")
#}
