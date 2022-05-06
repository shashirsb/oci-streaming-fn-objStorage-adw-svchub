# Copyright 2017, 2021 Oracle Corporation and/or affiliates.
# Licensed under the Universal Permissive License v 1.0 as shown at https://oss.oracle.com/licenses/upl

output "subnet_ids" {
  value = {
    "db"  = join(",", oci_core_subnet.db[*].id)
  }
}

output "int_lb" {
  value = var.load_balancers == "internal" || var.load_balancers == "both" ? oci_core_network_security_group.int_lb[0].id : ""
}

output "pub_lb" {
  value = var.load_balancers == "public" || var.load_balancers == "both" ? oci_core_network_security_group.pub_lb[0].id :""
}




