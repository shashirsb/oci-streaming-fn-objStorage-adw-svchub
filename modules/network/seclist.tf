# Copyright 2017, 2021 Oracle Corporation and/or affiliates.
# Licensed under the Universal Permissive License v 1.0 as shown at https://oss.oracle.com/licenses/upl


# db security checklist
resource "oci_core_security_list" "db" {
  compartment_id = var.compartment_id
  display_name   = var.label_prefix == "none" ? "db" : "${var.label_prefix}-db"
  vcn_id         = var.vcn_id

  egress_security_rules {
    protocol    = local.all_protocols
    destination = local.anywhere
  }

  ingress_security_rules {
    # ssh
    protocol = local.all_protocols
    source   = local.anywhere

    tcp_options {
      min = local.ssh_port
      max = local.ssh_port
    }
  }

} 

