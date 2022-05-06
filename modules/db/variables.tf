# Copyright 2017, 2019, Oracle Corporation and/or affiliates.  All rights reserved.
# Licensed under the Universal Permissive License v 1.0 as shown at https://oss.oracle.com/licenses/upl/

variable "db_identity" {
  type = object({
    compartment_id = string
    tenancy_id     = string
  })
}

variable "db_ssh_keys" {
  type = object({
    ssh_private_key_path = string
    ssh_public_key_path  = string
  })
}

variable "db_oci_general" {
  type = object({
    availability_domain = number
    label_prefix        = string
  })
}

variable "db_bastion" {
  type = object({
    bastion_public_ip = string
  })
}



variable "db_config" {
  type = object({
    db_system_shape         = string
    cpu_core_count          = number
    db_edition              = string
    db_admin_password       = string
    db_name                 = string
    db_home_db_name         = string
    db_version              = string
    db_home_display_name    = string
    db_disk_redundancy      = string
    db_system_display_name  = string
    hostname                = string
    n_character_set         = string
    character_set           = string
    db_workload             = string
    pdb_name                = string
    data_storage_size_in_gb = number
    license_model           = string
    node_count              = number
    data_storage_percentage = number
    db_software_image_ocid  = string
    db_private_ip           = string
    storage_management      = string
  })
}

variable "cluster_subnets" {
  type = map(any)
}





# ssh keys
variable "ssh_private_key" {}

variable "ssh_private_key_path" {}

variable "ssh_public_key" {}

variable "ssh_public_key_path" {}

# bastion
variable "create_bastion_host" {
  type = bool
}



variable "bastion_state" {}