# Copyright 2017, 2021 Oracle Corporation and/or affiliates.
# Licensed under the Universal Permissive License v 1.0 as shown at https://oss.oracle.com/licenses/upl

locals {
  ssh_private_key = var.ssh_private_key != "" ? var.ssh_private_key : var.ssh_private_key_path != "none" ? file(var.ssh_private_key_path) : null

}
