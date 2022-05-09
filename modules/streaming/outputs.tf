output "stream_poolname" {
  value = oci_streaming_stream_pool.StreamPool.name
}

output "Stream" {
  value = oci_streaming_stream.Stream.name
}

output "Stream_Patition" {
  value = oci_streaming_stream.Stream.partitions
}

output "Stream_id" {
  value = oci_streaming_stream.Stream.stream_pool_id
}

