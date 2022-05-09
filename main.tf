# Copyright 2017, 2021 Oracle Corporation and/or affiliates.
# Licensed under the Universal Permissive License v 1.0 as shown at https://oss.oracle.com/licenses/upl

module "vcn" {
  source  = "oracle-terraform-modules/vcn/oci"
  version = "3.0.0"

  # general oci parameters
  compartment_id = var.compartment_id
  label_prefix   = var.label_prefix

  # gateways
  create_internet_gateway  = var.load_balancers == "internal" ? false : true
  create_nat_gateway       = (var.load_balancers == "internal" || var.load_balancers == "both") ? true : false
  create_service_gateway   = true
  nat_gateway_public_ip_id = var.nat_gateway_public_ip_id

  # drg
  create_drg       = var.create_drg
  drg_display_name = var.drg_display_name

  # lpgs
  local_peering_gateways = var.local_peering_gateways

  # freeform_tags
  freeform_tags = var.freeform_tags["vcn"]

  # vcn
  vcn_cidrs                    = var.vcn_cidrs
  vcn_dns_label                = var.vcn_dns_label
  vcn_name                     = var.vcn_name
  lockdown_default_seclist     = var.lockdown_default_seclist
  internet_gateway_route_rules = var.internet_gateway_route_rules
  nat_gateway_route_rules      = var.nat_gateway_route_rules

}

# additional networking for oke
module "network" {
  source = "./modules/network"

  # general oci parameters
  compartment_id = var.compartment_id
  label_prefix   = var.label_prefix

   # networking parameters
  ig_route_id  = module.vcn.ig_route_id
  nat_route_id = module.vcn.nat_route_id
  subnets      = var.subnets
  vcn_id       = module.vcn.vcn_id

  # load balancer network parameters
  load_balancers = var.load_balancers

   # internal load balancer
  internal_lb_allowed_cidrs = var.internal_lb_allowed_cidrs
  internal_lb_allowed_ports = var.internal_lb_allowed_ports

  #  public load balancer
  public_lb_allowed_cidrs = var.public_lb_allowed_cidrs
  public_lb_allowed_ports = var.public_lb_allowed_ports

  # waf integration
  enable_waf = var.enable_waf

  depends_on = [
    module.vcn
  ]
}

# extensions to oke
module "extensions" {
  source = "./modules/extensions"

  # provider
  tenancy_id = var.tenancy_id

  # general oci parameters
  compartment_id = var.compartment_id
  label_prefix   = var.label_prefix

  # region parameters
  region = var.region

  # ssh keys
  ssh_private_key      = var.ssh_private_key
  ssh_private_key_path = var.ssh_private_key_path
  ssh_public_key       = var.ssh_public_key
  ssh_public_key_path  = var.ssh_public_key_path




  depends_on = [
    module.network
  ]

  providers = {
    oci.home = oci.home
  }
}

# database ADB - DW
module "db" {
  source = "./modules/db"

  # general oci parameters
  compartment_id = var.compartment_id 
  label_prefix   = var.label_prefix

  # ADB specific parameters
  cpu_core_count           = var.cpu_core_count
  data_storage_size_in_tbs = var.data_storage_size_in_tbs
  db_name                  = var.db_name
  admin_password           = var.admin_password
  db_version               = var.db_version
  db_workload              = var.db_workload
  /* display_name             = var.db_name */
  is_free_tier             = var.is_free_tier
  license_model            = var.license_model

  depends_on = [
    module.vcn
  ]
} 

# Object Storage resource
module "storage" {
  source = "./modules/storage"

  # general oci parameters
  compartment_id = var.compartment_id 
  label_prefix   = var.label_prefix

  # bucket parameters
  bucket_name                       = var.bucket_name
  bucket_namespace                  = var.bucket_namespace
  bucket_object_events_enabled      = var.bucket_object_events_enabled
  bucket_versioning                 = var.bucket_versioning

  # freeform_tags
  freeform_tags = {
      environment = "dev"
      entity        = "appdev"
    }

  depends_on = [
    module.vcn
  ]
}

# Object Storage resource
module "streaming" {
  source = "./modules/streaming"

  # general oci parameters
  compartment_id = var.compartment_id 
  label_prefix   = var.label_prefix

  
  # Streaming
  stream_poolname                  = var.stream_poolname
  stream_name                     = var.stream_name
  stream_partition                = var.stream_partition

  # freeform_tags
  freeform_tags = {
      environment = "dev"
      entity        = "appdev"
    }

  depends_on = [
    module.vcn
  ]
}

# Object Storage resource
module "fn" {
  source = "./modules/fn"

  # general oci parameters
  compartment_id = var.compartment_id 
  label_prefix   = var.label_prefix

  
  # function - fake-fun
  function_name                   = var.function_name
  ocir_repo_name                  = var.ocir_repo_name
  ocir_user_name                  = var.ocir_user_name
  application_name                = var.application_name

  # freeform_tags
  freeform_tags = {
      environment = "dev"
      entity        = "appdev"
    }

  depends_on = [
    module.vcn
  ]
}



