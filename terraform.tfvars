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
  }
   objectstorage = {
      environment = "dev"
      entity        = "appdev"
    }
    streaming = {
      environment = "dev"
      entity        = "appdev"
    }
}

# placeholder variable for debugging scripts. To be implemented in future
debug_mode = false

# ADB - DW variables
db_name        = "obadw2"
admin_password = "MyStrongPassword123"
db_version     = "19c"
# OLTP, DW, AJD, APEX
db_workload    = "DW"
# Must be false for AJD and APEX
is_free_tier   = "false"
license_model  = "LICENSE_INCLUDED"

# Storage - Object storage
bucket_name                     = "streambucket"
bucket_namespace                = "sehubjapacprod"
bucket_object_events_enabled    = true
bucket_versioning               = "Enabled"


# Streaming
stream_poolname                 = "StreamPool"
stream_name                     = "Stream" 
stream_partition                = 1

# fn
ocir_repo_name                  = "fedbank/functions" 
ocir_user_name                  = "oracleidentitycloudservice/shashib"
ocir_user_password              = "8TI6_ERWvN]g9lAxAk+v"

function_name                   = "my-new-function"
application_name                = "fake-fun"