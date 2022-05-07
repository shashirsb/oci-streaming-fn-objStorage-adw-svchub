# query ADs
data "oci_identity_availability_domain" "ad" {
  compartment_id = var.tenancy_id
  ad_number      = var.availability_domain
}
