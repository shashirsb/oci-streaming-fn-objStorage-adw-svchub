# Copyright 2017, 2021 Oracle Corporation and/or affiliates.
# Licensed under the Universal Permissive License v 1.0 as shown at https://oss.oracle.com/licenses/upl

locals {
  # scripting templates

  update_dynamic_group_template = templatefile("${path.module}/scripts/update_dynamic_group.template.sh",
    {
      dynamic_group_id   = var.use_cluster_encryption == true ? var.cluster_kms_dynamic_group_id : "null"
      dynamic_group_rule = local.dynamic_group_rule_this_cluster
      home_region        = data.oci_identity_regions.home_region.regions[0].name
    }
  )


}
