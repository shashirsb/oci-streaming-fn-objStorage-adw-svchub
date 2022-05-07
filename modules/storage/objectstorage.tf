resource "oci_objectstorage_bucket" "tf_bucket" {
    /* #Required
    compartment_id = var.compartment_id
    name = var.bucket_name
    namespace = var.bucket_namespace

    #Optional
  
    freeform_tags = var.freeform_tags
    object_events_enabled = var.bucket_object_events_enabled
    versioning = var.bucket_versioning */

     #Required
    compartment_id = "ocid1.compartment.oc1..aaaaaaaah6ibn4qjy6chh7ilzha53oeeacmrmghdh5ziqhzn2xtgubhxolga"
    name = "streambucket"
    namespace = "sehubjapacprod"

    #Optional
  
    freeform_tags = {something = "nothing"}
    object_events_enabled = true
    versioning = "Enabled"
}