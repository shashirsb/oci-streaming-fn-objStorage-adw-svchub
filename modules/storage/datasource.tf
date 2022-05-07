data "oci_compartment" "id" {
  compartment_id = var.compartment_id
}

data "oci_freeform_tags" "data" {
  compartment_id = var.freeform_tags
}