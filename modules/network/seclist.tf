# Copyright 2017, 2021 Oracle Corporation and/or affiliates.
# Licensed under the Universal Permissive License v 1.0 as shown at https://oss.oracle.com/licenses/upl
resource "oci_core_security_list" "control_plane_seclist" {
  compartment_id = var.compartment_id
  display_name   = var.label_prefix == "none" ? "control-plane" : "${var.label_prefix}-control-plane"
  vcn_id         = var.vcn_id

  dynamic "egress_security_rules" {
    iterator = cp_egress_iterator
    for_each = local.cp_egress_seclist

    content {

      description      = cp_egress_iterator.value["description"]
      destination      = cp_egress_iterator.value["destination"]
      destination_type = cp_egress_iterator.value["destination_type"]
      protocol         = cp_egress_iterator.value["protocol"]
      stateless        = cp_egress_iterator.value["stateless"]

      dynamic "tcp_options" {
        for_each = cp_egress_iterator.value["protocol"] == local.tcp_protocol && cp_egress_iterator.value["port"] != -1 ? [1] : []

        content {
          min = cp_egress_iterator.value["port"]
          max = cp_egress_iterator.value["port"]
        }
      }

    }
  }

  dynamic "ingress_security_rules" {
    iterator = cp_ingress_iterator
    for_each = local.cp_ingress_seclist

    content {
      description = cp_ingress_iterator.value["description"]
      protocol    = cp_ingress_iterator.value["protocol"]
      source      = cp_ingress_iterator.value["source"]
      stateless   = cp_ingress_iterator.value["stateless"]
      source_type = cp_ingress_iterator.value["source_type"]

      dynamic "tcp_options" {
        for_each = cp_ingress_iterator.value["protocol"] == local.tcp_protocol && cp_ingress_iterator.value["port"] != -1 ? [1] : []

        content {
          min = cp_ingress_iterator.value["port"]
          max = cp_ingress_iterator.value["port"]
        }
      }
    }
  }


  lifecycle {
    ignore_changes = [
      egress_security_rules, ingress_security_rules, defined_tags
    ]
  }
}

/* resource "oci_core_security_list" "bastion_seclist" {
  compartment_id = var.compartment_id
  display_name   = var.label_prefix == "none" ? "bastion" : "${var.label_prefix}-bastion"
  vcn_id         = var.vcn_id

  dynamic "ingress_security_rules" {
    iterator = bastion_ingress_iterator
    for_each = local.bastion_ingress_seclist

    content {
      description = bastion_ingress_iterator.value["description"]
      protocol    = bastion_ingress_iterator.value["protocol"]
      source      = bastion_ingress_iterator.value["source"]
      stateless   = bastion_ingress_iterator.value["stateless"]
      source_type = bastion_ingress_iterator.value["source_type"]

      dynamic "tcp_options" {
        for_each = bastion_ingress_iterator.value["protocol"] == local.tcp_protocol && bastion_ingress_iterator.value["port"] != -1 ? [1] : []

        content {
          min = bastion_ingress_iterator.value["port"]
          max = bastion_ingress_iterator.value["port"]
        }
      }
    }
  }


  lifecycle {
    ignore_changes = [
      egress_security_rules, ingress_security_rules, defined_tags
    ]
  }
} */

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
    protocol = local.tcp_protocol
    source   = local.vcn_cidr

    tcp_options {
      min = local.ssh_port
      max = local.ssh_port
    }
  }
  ingress_security_rules {
    # db port
    protocol = local.tcp_protocol
    source   = local.vcn_cidr

    tcp_options {
      min = local.db_port
      max = local.db_port
    }
  }
}

resource "oci_core_security_list" "operator_seclist" {
  compartment_id = var.compartment_id
  display_name   = var.label_prefix == "none" ? "operator" : "${var.label_prefix}-operator"
  vcn_id         = var.vcn_id

  dynamic "ingress_security_rules" {
    iterator = operator_ingress_iterator
    for_each = local.operator_ingress_seclist

    content {
      description = operator_ingress_iterator.value["description"]
      protocol    = operator_ingress_iterator.value["protocol"]
      source      = operator_ingress_iterator.value["source"]
      stateless   = operator_ingress_iterator.value["stateless"]
      source_type = operator_ingress_iterator.value["source_type"]

      dynamic "tcp_options" {
        for_each = operator_ingress_iterator.value["protocol"] == local.tcp_protocol && operator_ingress_iterator.value["port"] != -1 ? [1] : []

        content {
          min = operator_ingress_iterator.value["port"]
          max = operator_ingress_iterator.value["port"]
        }
      }
    }
  }


  lifecycle {
    ignore_changes = [
      egress_security_rules, ingress_security_rules, defined_tags
    ]
  }
}
