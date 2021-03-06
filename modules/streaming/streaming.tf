resource "oci_streaming_stream_pool" "StreamPool" {
    compartment_id = var.compartment_id
    name = "${var.label_prefix}-${var.stream_poolname}"
    freeform_tags         = var.freeform_tags
}

resource "oci_streaming_stream" "Stream" {
    name = "${var.label_prefix}${var.stream_name}"
    partitions = var.stream_partition
    stream_pool_id = oci_streaming_stream_pool.StreamPool.id
    freeform_tags         = var.freeform_tags
}

