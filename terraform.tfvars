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
vcn_dns_label = "fedbank"
vcn_name      = "vcnfedbank"

# availability_domains
availability_domains = {
  db       = 1
}




# freeform_tags
freeform_tags = {
  # vcn, bastion and operator freeform_tags are required
  # add more freeform_tags in each as desired
  vcn = {
    environment = "dev"
  },
   objectstorage = {
      environment = "dev"
      entity        = "appdev"
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

# Storage - Object storage
bucket_name                     = "streambucket"
bucket_namespace                = "something"
bucket_object_events_enabled    = true
bucket_versioning               = "Enabled"