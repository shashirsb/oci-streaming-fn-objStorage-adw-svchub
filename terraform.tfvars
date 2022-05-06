# Copyright 2017, 2021 Oracle Corporation and/or affiliates.
# Licensed under the Universal Permissive License v 1.0 as shown at https://oss.oracle.com/licenses/upl

api_fingerprint = "4b:c9:75:ad:74:c5:fc:51:19:db:52:d0:70:0c:11:ef"
api_private_key_path =  "~/.oci/oci_api_key.pem"
tenancy_id = "ocid1.tenancy.oc1..aaaaaaaaro7aox2fclu4urtpgsbacnrmjv46e7n4fw3sc2wbq24l7dzf3kba"
user_id = "ocid1.user.oc1..aaaaaaaafrfzsvmm6nwpwjor2woc3pejml6l6bhuv2mxqqbj6moj7arck6ua"
compartment_id = "ocid1.compartment.oc1..aaaaaaaah6ibn4qjy6chh7ilzha53oeeacmrmghdh5ziqhzn2xtgubhxolga"
label_prefix = "appdev"
dynamic_group_id = "ocid1.dynamicgroup.oc1..aaaaaaaa7i6e22djtdtrvivzzaehhwplcm7pi3jvmyzcdij6v7n3ow5aqoha"
# Identity and access parameters
# api_private_key      = <<EOT
#-----BEGIN RSA PRIVATE KEY-----
#content+of+api+key
#-----END RSA PRIVATE KEY-----
#EOT


home_region = "us-ashburn-1"
region = "us-phoenix-1"



# ssh keys
#ssh_private_key      = ""
# ssh_private_key    = <<EOT
#-----BEGIN RSA PRIVATE KEY-----
# xxxxx
# -----END RSA PRIVATE KEY-----
#EOT
ssh_private_key_path = "~/.oci/master-ssh-private-key"
# ssh_public_key       = ""
ssh_public_key_path = "~/.oci/master-ssh-key.pub"


# networking
create_drg                   = false
drg_display_name             = "drg"

internet_gateway_route_rules = []

local_peering_gateways = {}

lockdown_default_seclist = true

nat_gateway_route_rules = []

nat_gateway_public_ip_id = "none"

subnets = {
  bastion  = { netnum = 0, newbits = 13 }
  operator = { netnum = 1, newbits = 13 }
  cp       = { netnum = 2, newbits = 13 }
  db       = { netnum = 3, newbits = 13 }
  int_lb   = { netnum = 16, newbits = 11 }
  pub_lb   = { netnum = 17, newbits = 11 }
  fss      = { netnum = 18, newbits = 11 }
  workers  = { netnum = 1, newbits = 2 } 

}

vcn_cidrs     = ["10.2.0.0/16"]
vcn_dns_label = "oke"
vcn_name      = "vcnoke"

# bastion host
create_bastion_host = true
bastion_access      = ["anywhere"]
bastion_image_id    = "Autonomous"
bastion_os_version  = "7.9"
bastion_shape = {
  shape            = "VM.Standard.E4.Flex",
  ocpus            = 1,
  memory           = 4,
  boot_volume_size = 50
}
bastion_state    = "RUNNING"
bastion_timezone = "Etc/UTC"
bastion_type     = "public"
upgrade_bastion  = false

## bastion notification
enable_bastion_notification   = false
bastion_notification_endpoint = ""
bastion_notification_protocol = "EMAIL"
bastion_notification_topic    = "bastion_server_notification"

# bastion service
create_bastion_service        = false
bastion_service_access        = ["0.0.0.0/0"]
bastion_service_name          = "bastion"
bastion_service_target_subnet = "operator"

# operator host
create_operator                    = true
operator_image_id                  = "Oracle"
enable_operator_instance_principal = true
operator_nsg_ids                   = []
operator_os_version                = "7.9"
operator_shape = {
  shape            = "VM.Standard.E4.Flex",
  ocpus            = 1,
  memory           = 4,
  boot_volume_size = 50
}
operator_state    = "RUNNING"
operator_timezone = "Etc/UTC"
upgrade_operator  = false

# Operator in-transit encryption for the data volume's paravirtualized attachment.
enable_operator_pv_encryption_in_transit = false

# operator volume kms integration
operator_volume_kms_id = ""

## operator notification
enable_operator_notification   = false
operator_notification_endpoint = ""
operator_notification_protocol = "EMAIL"
operator_notification_topic    = ""

# availability_domains
availability_domains = {
  bastion  = 1,
  operator = 1,
  fss      = 1,
  db       = 1
}

# oke cluster options
admission_controller_options = {
  PodSecurityPolicy = false
}
allow_node_port_access       = true
allow_worker_internet_access = true
allow_worker_ssh_access      = true
cluster_name                 = "oke"
control_plane_type           = "private"
control_plane_allowed_cidrs  = ["0.0.0.0/0"]
control_plane_nsgs           = []
dashboard_enabled            = true
kubernetes_version           = "v1.21.5"
pods_cidr                    = "10.244.0.0/16"
services_cidr                = "10.96.0.0/16"

## oke cluster kms integration
use_cluster_encryption = false
cluster_kms_key_id     = ""

### oke node pool volume kms integration
use_node_pool_volume_encryption = false
node_pool_volume_kms_key_id     = ""

## oke cluster container image policy and keys
use_signed_images = false
image_signing_keys = []

# node pools
check_node_active = "all"
enable_pv_encryption_in_transit = false
node_pools = {
  np1 = { shape = "VM.Standard.E4.Flex", ocpus = 1, memory = 16, node_pool_size = 1, boot_volume_size = 150, label = { app = "frontend", pool = "np1" } }
  # np2 = { shape = "VM.Standard.E4.Flex", ocpus = 1, memory = 16, node_pool_size = 1, boot_volume_size = 150, label = { app = "frontend", pool = "np2" } }
  # np3 = { shape = "VM.Standard.E4.Flex", ocpus = 1, memory = 16, node_pool_size = 1, boot_volume_size = 150, label = { app = "frontend", pool = "np1" } }
  # np4 = { shape = "VM.Standard.E4.Flex", ocpus = 1, memory = 16, node_pool_size = 1, boot_volume_size = 150, label = { app = "frontend", pool = "np1" } }
  # np2 = {shape="VM.Standard.E4.Flex",ocpus=4,memory=16,node_pool_size=1,boot_volume_size=150, label={app="backend",pool="np2"}}
  # np3 = {shape="VM.Standard.A1.Flex",ocpus=8,memory=16,node_pool_size=1,boot_volume_size=150, label={pool="np3"}}
  # np4 = {shape="BM.Standard2.52",node_pool_size=1,boot_volume_size=150}
  # np5 = {shape="VM.Optimized3.Flex",node_pool_size=6}
  # np5 = {shape="BM.Standard.A1.160",node_pool_size=6}
  # np6 = {shape="VM.Standard.E2.2", node_pool_size=5}
  # np7 = {shape="BM.DenseIO2.52", node_pool_size=5}
  # np8 = {shape="BM.GPU3.8", node_pool_size=1}
  # np9 = {shape="BM.GPU4.8", node_pool_size=5}
  # np10 = {shape="BM.HPC2.36	", node_pool_size=5}
}
node_pool_image_id    = "none"
node_pool_name_prefix = "np"
node_pool_os          = "Oracle Linux"
node_pool_os_version  = "7.9"
node_pool_timezone    = "Etc/UTC"
worker_nsgs           = []
worker_type           = "public"

# upgrade of existing node pools
upgrade_nodepool        = false
node_pools_to_drain     = ["np1", "np2"]
nodepool_upgrade_method = "out_of_place"

# oke load balancers
enable_waf                   = false
load_balancers               = "both"
preferred_load_balancer      = "public"
# internal_lb_allowed_cidrs  = ["172.16.1.0/24", "172.16.2.0/24"] # By default, anywhere i.e. 0.0.0.0/0 is allowed
# internal_lb_allowed_ports  = [80, 443, "7001-7005"] # By default, only 80 and 443 are allowed
# public_lb_allowed_cidrs    = ["0.0.0.0/0"] # By default, anywhere i.e. 0.0.0.0/0 is allowed
# public_lb_allowed_ports    = [443,"9001-9002"] # By default, only 443 is allowed

#fss
create_fss = false
fss_mount_path = "/oke_fss"
max_fs_stat_bytes = 23843202333
max_fs_stat_files = 223442


# ocir
email_address    = ""
secret_id        = "none"
secret_name      = "ocirsecret"
secret_namespace = "default"
username         = ""

# calico
enable_calico  = false
calico_version = "3.19"

# horizontal and vertical pod autoscaling
enable_metric_server = false
enable_vpa           = false
vpa_version          = 0.8

#OPA Gatekeeper
enable_gatekeeper = false
gatekeeeper_version = "3.7"

# service account
create_service_account               = false
service_account_name                 = ""
service_account_namespace            = ""
service_account_cluster_role_binding = ""

# freeform_tags
freeform_tags = {
  # vcn, bastion and operator freeform_tags are required
  # add more freeform_tags in each as desired
  vcn = {
    environment = "dev"
  }
  bastion = {
    access      = "public",
    environment = "dev",
    role        = "bastion",
    security    = "high"
  }
  operator = {
    access      = "restricted",
    environment = "dev",
    role        = "operator",
    security    = "high"
  }
  oke = {
    service_lb  = {
      environment = "dev"
      role        = "load balancer"
    }
  }
}

# placeholder variable for debugging scripts. To be implemented in future
debug_mode = false

# db variables

db_system_shape           = "VM.Standard2.1"
cpu_core_count            = 2
db_edition                = "ENTERPRISE_EDITION"
db_admin_password         = "BEstrO0ng_#12"
db_name                   = "basedb"
db_home_db_name           = "basedb2"
db_version                = "19.0.0.0"
db_home_display_name      = "basedbhome"
db_disk_redundancy        = "HIGH"
db_system_display_name    = "basedb_system"
hostname                  = "myoracledb"
n_character_set           = "AL16UTF16"
character_set             = "AL32UTF8"
db_workload               = "OLTP"
pdb_name                  = "pdb1"
data_storage_size_in_gb   = 256
license_model             = "LICENSE_INCLUDED"
node_count                = 1
data_storage_percentage   = 40
db_software_image_ocid    = "ocid1.image.oc1..aaaaaaaarh4xixh5gaqlh4fm2l3vh55jbrj3no4nshlagv5rwu3i2qynqiqq"
db_private_ip             = "10.2.0.29" 
storage_management        = "LVM" 