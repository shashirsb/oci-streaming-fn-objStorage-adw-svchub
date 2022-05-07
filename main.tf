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

# database 
/* module "db" {
  source = "./modules/db"

  # ssh keys
  ssh_private_key      = var.ssh_private_key
  ssh_private_key_path = var.ssh_private_key_path
  ssh_public_key       = var.ssh_public_key
  ssh_public_key_path  = var.ssh_public_key_path

  create_bastion_host = var.create_bastion_host 
  bastion_state       = var.bastion_state

   db_identity = {
    compartment_id = var.compartment_id
    tenancy_id     = var.tenancy_id
  }

  # since they have the same signature, we can reuse that
  db_ssh_keys = {
    ssh_private_key_path = var.ssh_private_key_path
    ssh_public_key_path  = var.ssh_public_key_path
  }

  db_oci_general = {
    availability_domain = var.availability_domains["db"]
    label_prefix        = var.label_prefix
  }

  db_bastion = {
    bastion_public_ip = local.bastion_public_ip
  }

  cluster_subnets = module.network.subnet_ids


  db_config = {
    db_system_shape         = var.db_system_shape
    cpu_core_count          = var.cpu_core_count
    db_edition              = var.db_edition
    db_admin_password       = var.db_admin_password
    db_name                 = var.db_name
    db_home_db_name         = var.db_home_db_name
    db_version              = var.db_version
    db_home_display_name    = var.db_home_display_name
    db_disk_redundancy      = var.db_disk_redundancy
    db_system_display_name  = var.db_system_display_name
    hostname                = var.hostname
    n_character_set         = var.n_character_set
    character_set           = var.character_set
    db_workload             = var.db_workload
    pdb_name                = var.pdb_name
    data_storage_size_in_gb = var.data_storage_size_in_gb
    license_model           = var.license_model
    node_count              = var.node_count
    data_storage_percentage = var.data_storage_percentage
    db_software_image_ocid  = var.db_software_image_ocid
    db_private_ip           = var.db_private_ip
    storage_management      = var.storage_management
  }

  depends_on = [
    module.oke
  ]
}  */


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


