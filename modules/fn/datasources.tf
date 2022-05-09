data "oci_functions_applications" "function_applications" {
  compartment_id = var.compartment_id
  display_name   = "${var.application_name}"
}

locals {
  
}


# Randoms
resource "random_string" "deploy_id" {
  length  = 4
  special = false
}