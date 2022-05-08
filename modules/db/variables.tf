# Variables
variable "compartment_id" { type = string }
variable "db_name"        { type = string }
variable "admin_password" { type = string }
variable "db_version"     { type = string }
# OLTP, DW, AJD, APEX
variable "db_workload"    { type = string }
# Must be false for AJD and APEX
variable "is_free_tier"   { type = string }
# BRING_YOUR_OWN_LICENSE or LICENSE_INCLUDED
variable "license_model"  { type = string }

variable "cpu_core_count" {
  type    = number
  default = 1
}

variable "data_storage_size_in_tbs" {
  type    = number
  default = 1
}

variable "label_prefix" {}