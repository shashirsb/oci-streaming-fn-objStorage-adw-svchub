data "oci_streaming_stream_pool" "StreamPool" {
    stream_pool_id = "${oci_streaming_stream_pool.StreamPool.id}"
}