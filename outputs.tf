# Copyright 2017, 2021 Oracle Corporation and/or affiliates.
# Licensed under the Universal Permissive License v 1.0 as shown at https://oss.oracle.com/licenses/upl

# for reuse 



output "ig_route_id" {
  description = "id of route table to vcn internet gateway"
  value       = module.vcn.ig_route_id
}

output "nat_route_id" {
  description = "id of route table to nat gateway attached to vcn"
  value       = module.vcn.nat_route_id
}

/* output "int_lb_nsg" {
  description = "id of default NSG that can be associated with the internal load balancer"
  value       = module.network.int_lb
} */

/* output "pub_lb_nsg" {
  description = "id of default NSG that can be associated with the internal load balancer"
  value       = module.network.pub_lb
} */

output "subnet_ids" {
  description = "map of subnet ids (worker, int_lb, pub_lb) used by OKE."
  value       = module.network.subnet_ids
}

output "vcn_id" {
  description = "id of vcn where oke is created. use this vcn id to add additional resources"
  value       = module.vcn.vcn_id
}

///////////////////////////////////

output "db_name" {
  value = module.db.oci_database_autonomous_database.adb_dw.display_name
}

output "db_state" {
  value = module.db.oci_database_autonomous_database.adb_dw.state
}


output "bucket_name" {
  value = module.storage.oci_objectstorage_bucket.tf_bucket.name
}

output "bucket_id" {
  value = module.storage.oci_objectstorage_bucket.tf_bucket.bucket_id
}

output "stream_poolname" {
  value = module.streaming.oci_streaming_stream_pool.StreamPool.name
}

output "Stream" {
  value = module.streaming.oci_streaming_stream.Stream.name
}

output "Stream_Patition" {
  value = module.streaming.oci_streaming_stream.Stream.partitions
}

output "Stream_id" {
  value = module.streaming.oci_streaming_stream.Stream.stream_pool_id
}
