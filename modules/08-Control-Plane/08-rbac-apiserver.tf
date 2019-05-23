resource "null_resource" "rbac_apiserver" {
  connection {
    type         = "ssh"
    user         = var.node_user
    host         = var.apiserver_public_ip
    password     = var.node_password
    bastion_host = var.bastionIP
  }
  provisioner "remote-exec" {
    inline = [
      "echo ${jsonencode(var.etcd_server_null_ids)}",
      "echo ${jsonencode(null_resource.control_plane_server.*.id)}",
      "echo ${null_resource.rbac_ccm.id}",
    ]
  }
  provisioner "remote-exec" {
    scripts = [
      "${path.module}/apiserver-rbac.sh",
    ]
  }
}

