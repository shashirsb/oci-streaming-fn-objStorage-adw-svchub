# Copyright 2017, 2019, Oracle Corporation and/or affiliates.  All rights reserved.
# Licensed under the Universal Permissive License v 1.0 as shown at https://oss.oracle.com/licenses/upl/

# Resources
resource "oci_database_autonomous_database" "adb_dw" {
  compartment_id           = var.compartment_id
  cpu_core_count           = var.cpu_core_count
  data_storage_size_in_tbs = var.data_storage_size_in_tbs
  db_name                  = "${var.label_prefix}${var.db_name}"
  admin_password           = var.admin_password
  db_version               = var.db_version
  db_workload              = var.db_workload
  display_name             = "${var.label_prefix}${var.db_name}"
  is_free_tier             = var.is_free_tier
  license_model            = var.license_model
}