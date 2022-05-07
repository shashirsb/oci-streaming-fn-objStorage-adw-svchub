resource "oci_objectstorage_bucket" "tf_bucket" {
    #Required
    compartment_id = data.compartment.id
    name = var.bucket_name
    namespace = var.bucket_namespace

    #Optional
  
    freeform_tags = data.freeform_tags
    object_events_enabled = var.bucket_object_events_enabled
    versioning = var.bucket_versioning

  
}