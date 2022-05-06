# Copyright 2017, 2021 Oracle Corporation and/or affiliates.
# Licensed under the Universal Permissive License v 1.0 as shown at https://oss.oracle.com/licenses/upl




resource "null_resource" "install_xauth_on_operator" {
  connection {
    host        = var.operator_private_ip
    private_key = local.ssh_private_key
    timeout     = "40m"
    type        = "ssh"
    user        = "opc"

    bastion_host        = var.bastion_public_ip
    bastion_user        = "opc"
    bastion_private_key = local.ssh_private_key
  }

  provisioner "file" {
    content     = local.install_xauth_template
    destination = "/home/opc/install_xauth.sh"
  }

  provisioner "remote-exec" {
    inline = [
      "chmod +x $HOME/install_xauth.sh",
      "$HOME/install_xauth.sh",
      "rm -f $HOME/install_xauth.sh"
    ]
  }

   count = var.create_bastion_host == true && var.bastion_state == "RUNNING" && var.create_operator == true ? 1 : 0
}


resource "null_resource" "install_wktui_on_operator" {
  connection {
    host        = var.operator_private_ip
    private_key = local.ssh_private_key
    timeout     = "40m"
    type        = "ssh"
    user        = "opc"

    bastion_host        = var.bastion_public_ip
    bastion_user        = "opc"
    bastion_private_key = local.ssh_private_key
  }

  depends_on = [null_resource.install_xauth_on_operator]

  provisioner "file" {
    content     = local.install_wktui_template
    destination = "/home/opc/install_wktui.sh"
  }

  provisioner "remote-exec" {
    inline = [
      "chmod +x $HOME/install_wktui.sh",
      "$HOME/install_wktui.sh",
      "rm -f $HOME/install_wktui.sh"
    ]
  }

   count = var.create_bastion_host == true && var.bastion_state == "RUNNING" && var.create_operator == true ? 1 : 0
}

resource "null_resource" "install_wls_on_operator" {
  connection {
    host        = var.operator_private_ip
    private_key = local.ssh_private_key
    timeout     = "40m"
    type        = "ssh"
    user        = "opc"

    bastion_host        = var.bastion_public_ip
    bastion_user        = "opc"
    bastion_private_key = local.ssh_private_key
  }

  depends_on = [null_resource.install_wktui_on_operator]

  provisioner "file" {
    content     = local.install_wls_template
    destination = "/home/opc/install_wls.sh"
  }

  provisioner "remote-exec" {
    inline = [
      "chmod +x $HOME/install_wls.sh",
      "$HOME/install_wls.sh",
      "rm -f $HOME/install_wls.sh"
    ]
  }

   count = var.create_bastion_host == true && var.bastion_state == "RUNNING" && var.create_operator == true ? 1 : 0
}

resource "null_resource" "install_kubectl_on_operator" {
  connection {
    host        = var.operator_private_ip
    private_key = local.ssh_private_key
    timeout     = "40m"
    type        = "ssh"
    user        = "opc"

    bastion_host        = var.bastion_public_ip
    bastion_user        = "opc"
    bastion_private_key = local.ssh_private_key
  }

  depends_on = [null_resource.install_wls_on_operator]

  provisioner "file" {
    content     = local.install_kubectl_template
    destination = "/home/opc/install_kubectl.sh"
  }

  provisioner "remote-exec" {
    inline = [
      "chmod +x $HOME/install_kubectl.sh",
      "$HOME/install_kubectl.sh",
      "rm -f $HOME/install_kubectl.sh"
    ]
  }

  count = var.create_bastion_host == true && var.bastion_state == "RUNNING" && var.create_operator == true ? 1 : 0
}

# helm
resource "null_resource" "install_helm_on_operator" {
  connection {
    host        = var.operator_private_ip
    private_key = local.ssh_private_key
    timeout     = "40m"
    type        = "ssh"
    user        = "opc"

    bastion_host        = var.bastion_public_ip
    bastion_user        = "opc"
    bastion_private_key = local.ssh_private_key
  }

  depends_on = [null_resource.install_kubectl_on_operator, null_resource.write_kubeconfig_on_operator]

  provisioner "file" {
    content     = local.install_helm_template
    destination = "/home/opc/install_helm.sh"
  }

  provisioner "remote-exec" {
    inline = [
      "chmod +x $HOME/install_helm.sh",
      "bash $HOME/install_helm.sh",
      "rm -f $HOME/install_helm.sh"
    ]
  }

  count = var.create_bastion_host == true && var.bastion_state == "RUNNING" && var.create_operator == true ? 1 : 0
}

# vnc
resource "null_resource" "install_vnc_on_operator" {
  connection {
    host        = var.operator_private_ip
    private_key = local.ssh_private_key
    timeout     = "40m"
    type        = "ssh"
    user        = "opc"

    bastion_host        = var.bastion_public_ip
    bastion_user        = "opc"
    bastion_private_key = local.ssh_private_key
  }

  depends_on = [null_resource.install_helm_on_operator]

  provisioner "file" {
    content     = local.install_vnc_template
    destination = "/home/opc/install_vnc.sh"
  }

  provisioner "remote-exec" {
    inline = [
      "chmod +x $HOME/install_vnc.sh",
      "bash $HOME/install_vnc.sh",
      "rm -f $HOME/install_vnc.sh"
    ]
  }

  count = var.create_bastion_host == true && var.bastion_state == "RUNNING" && var.create_operator == true ? 1 : 0
}

resource "null_resource" "install_vncstart_on_operator" {
  connection {
    host        = var.operator_private_ip
    private_key = local.ssh_private_key
    timeout     = "40m"
    type        = "ssh"
    user        = "opc"

    bastion_host        = var.bastion_public_ip
    bastion_user        = "opc"
    bastion_private_key = local.ssh_private_key
  }

  depends_on = [null_resource.install_vnc_on_operator]

  provisioner "file" {
    content     = local.install_vncstart_template
    destination = "/home/opc/install_vncstart.sh"
  }

  provisioner "remote-exec" {
    inline = [
      "chmod 777 $HOME/install_vncstart.sh",
      "$HOME/install_vncstart.sh",
      "rm -f $HOME/install_vncstart.sh"
    ]
  }

  count = var.create_bastion_host == true && var.bastion_state == "RUNNING" && var.create_operator == true ? 1 : 0
}



#################

/* resource "null_resource" "install_xauth_on_bastion" {
  connection {
    host        = var.bastion_public_ip
    private_key = local.ssh_private_key
    timeout     = "40m"
    type        = "ssh"
    user        = "opc"
  }

  provisioner "file" {
    content     = local.install_xauth_template
    destination = "/home/opc/install_xauth.sh"
  }

 depends_on = [null_resource.install_helm_on_operator]
 
  provisioner "remote-exec" {
    inline = [
      "chmod +x $HOME/install_xauth.sh",
      "$HOME/install_xauth.sh",
      "rm -f $HOME/install_xauth.sh"
    ]
  }

   count = var.create_bastion_host == true && var.bastion_state == "RUNNING" && var.create_operator == true ? 1 : 0
}

resource "null_resource" "install_wktui_on_bastion" {
  connection {
    host        = var.bastion_public_ip
    private_key = local.ssh_private_key
    timeout     = "40m"
    type        = "ssh"
    user        = "opc"
  }

  depends_on = [null_resource.install_xauth_on_bastion]

  provisioner "file" {
    content     = local.install_wktui_template
    destination = "/home/opc/install_wktui.sh"
  }

  provisioner "remote-exec" {
    inline = [
      "chmod +x $HOME/install_wktui.sh",
      "$HOME/install_wktui.sh",
      "rm -f $HOME/install_wktui.sh"
    ]
  }

   count = var.create_bastion_host == true && var.bastion_state == "RUNNING" && var.create_operator == true ? 1 : 0
}

resource "null_resource" "install_wls_on_bastion" {
  connection {
    host        = var.bastion_public_ip
    private_key = local.ssh_private_key
    timeout     = "40m"
    type        = "ssh"
    user        = "opc"
  }

  depends_on = [null_resource.install_wktui_on_bastion]

  provisioner "file" {
    content     = local.install_wls_template
    destination = "/home/opc/install_wls.sh"
  }

  provisioner "remote-exec" {
    inline = [
      "chmod +x $HOME/install_wls.sh",
      "$HOME/install_wls.sh",
      "rm -f $HOME/install_wls.sh"
    ]
  }

   count = var.create_bastion_host == true && var.bastion_state == "RUNNING" && var.create_operator == true ? 1 : 0
} */

/* resource "null_resource" "install_kubectl_on_bastion" {
  connection {
    host        = var.bastion_public_ip
    private_key = local.ssh_private_key
    timeout     = "40m"
    type        = "ssh"
    user        = "opc"
  }

  depends_on = [null_resource.install_vncstart_on_operator]

  provisioner "file" {
    content     = local.install_kubectl_bastion_template
    destination = "/home/opc/install_kubectl_bastion.sh"
  }

  provisioner "remote-exec" {
    inline = [
      "chmod +x $HOME/install_kubectl_bastion.sh",
      "$HOME/install_kubectl_bastion.sh",
      "rm -f $HOME/install_kubectl_bastion.sh"
    ]
  }

  count = var.create_bastion_host == true && var.bastion_state == "RUNNING" && var.create_operator == true ? 1 : 0
}

# helm
resource "null_resource" "install_helm_on_bastion" {
  connection {
    host        = var.bastion_public_ip
    private_key = local.ssh_private_key
    timeout     = "40m"
    type        = "ssh"
    user        = "opc"

  }

  depends_on = [null_resource.install_kubectl_on_bastion, null_resource.write_kubeconfig_on_bastion]

  provisioner "file" {
    content     = local.install_helm_template
    destination = "/home/opc/install_helm.sh"
  }

  provisioner "remote-exec" {
    inline = [
      "chmod +x $HOME/install_helm.sh",
      "bash $HOME/install_helm.sh",
      "rm -f $HOME/install_helm.sh"
    ]
  }

  count = var.create_bastion_host == true && var.bastion_state == "RUNNING" && var.create_operator == true ? 1 : 0
} */

