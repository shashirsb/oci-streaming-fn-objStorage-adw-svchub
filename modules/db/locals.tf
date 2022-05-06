# Copyright 2017, 2019, Oracle Corporation and/or affiliates.  All rights reserved.
# Licensed under the Universal Permissive License v 1.0 as shown at https://oss.oracle.com/licenses/upl/


locals {
  ssh_private_key = var.ssh_private_key != "" ? var.ssh_private_key : var.ssh_private_key_path != "none" ? file(var.ssh_private_key_path) : null
  icmp_protocol = 1
  tcp_protocol  = 6
  all_protocols = "all"

  anywhere = "0.0.0.0/0"

  db_port = 1521

  ssh_port          = 22

  ad_names = [
    for ad_name in data.oci_identity_availability_domains.ad_list.availability_domains :
    ad_name.name
  ]

  post_provisioning_ops = var.create_bastion_host == true && var.bastion_state == "RUNNING"  ? true : false

}

