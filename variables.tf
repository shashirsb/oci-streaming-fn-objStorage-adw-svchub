# Copyright 2017, 2021 Oracle Corporation and/or affiliates.
# Licensed under the Universal Permissive License v 1.0 as shown at https://oss.oracle.com/licenses/upl

# OCI Provider parameters
variable "api_fingerprint" {
  default     = ""
  description = "Fingerprint of the API private key to use with OCI API."
  type        = string
}

variable "api_private_key" {
  default     = ""
  description = "The contents of the private key file to use with OCI API. This takes precedence over private_key_path if both are specified in the provider."
  sensitive   = true
  type        = string
}

variable "api_private_key_password" {
  default     = ""
  description = "The corresponding private key password to use with the api private key if it is encrypted."
  sensitive   = true
  type        = string
}

variable "api_private_key_path" {
  default     = ""
  description = "The path to the OCI API private key."
  type        = string
}

variable "home_region" {
  # List of regions: https://docs.cloud.oracle.com/iaas/Content/General/Concepts/regions.htm#ServiceAvailabilityAcrossRegions
  description = "The tenancy's home region. Required to perform identity operations."
  type        = string
}

variable "region" {
  # List of regions: https://docs.cloud.oracle.com/iaas/Content/General/Concepts/regions.htm#ServiceAvailabilityAcrossRegions
  description = "The OCI region where OKE resources will be created."
  type        = string
}

variable "tenancy_id" {
  description = "The tenancy id of the OCI Cloud Account in which to create the resources."
  type        = string
}

variable "user_id" {
  description = "The id of the user that terraform will use to create the resources."
  type        = string
  default     = ""
}

# General OCI parameters
variable "compartment_id" {
  description = "The compartment id where to create all resources."
  type        = string
}

variable "label_prefix" {
  default     = "none"
  description = "A string that will be prepended to all resources."
  type        = string
}

# ssh keys
variable "ssh_private_key" {
  default     = ""
  description = "The contents of the private ssh key file."
  sensitive   = true
  type        = string
}

variable "ssh_private_key_path" {
  default     = "none"
  description = "The path to ssh private key."
  type        = string
}

variable "ssh_public_key" {
  default     = ""
  description = "The contents of the ssh public key."
  type        = string
}

variable "ssh_public_key_path" {
  default     = "none"
  description = "The path to ssh public key."
  type        = string
}

# vcn parameters
variable "create_drg" {
  description = "whether to create Dynamic Routing Gateway. If set to true, creates a Dynamic Routing Gateway and attach it to the VCN."
  type        = bool
  default     = false
}

variable "drg_display_name" {
  description = "(Updatable) Name of Dynamic Routing Gateway. Does not have to be unique."
  type        = string
  default     = "drg"
}

variable "internet_gateway_route_rules" {
  description = "(Updatable) List of routing rules to add to Internet Gateway Route Table"
  type        = list(map(string))
  default     = null
}

variable "local_peering_gateways" {
  description = "Map of Local Peering Gateways to attach to the VCN."
  type        = map(any)
  default     = null
}

variable "lockdown_default_seclist" {
  description = "whether to remove all default security rules from the VCN Default Security List"
  default     = true
  type        = bool
}

variable "nat_gateway_route_rules" {
  description = "(Updatable) List of routing rules to add to NAT Gateway Route Table"
  type        = list(map(string))
  default     = null
}

variable "nat_gateway_public_ip_id" {
  description = "OCID of reserved IP address for NAT gateway. The reserved public IP address needs to be manually created."
  default     = "none"
  type        = string
}

variable "subnets" {
  description = "parameters to cidrsubnet function to calculate subnet masks within the VCN."
  default = {
    bastion  = { netnum = 0, newbits = 13 }
    operator = { netnum = 1, newbits = 13 }
    cp       = { netnum = 2, newbits = 13 }
    int_lb   = { netnum = 16, newbits = 11 }
    pub_lb   = { netnum = 17, newbits = 11 }
    workers  = { netnum = 1, newbits = 2 }
  }
  type = map(any)
}

variable "vcn_cidrs" {
  default     = ["10.0.0.0/16"]
  description = "The list of IPv4 CIDR blocks the VCN will use."
  type        = list(string)
}

variable "vcn_dns_label" {
  default     = "oke"
  description = "A DNS label for the VCN, used in conjunction with the VNIC's hostname and subnet's DNS label to form a fully qualified domain name (FQDN) for each VNIC within this subnet."
  type        = string
}

variable "vcn_name" {
  default     = "oke-vcn"
  description = "name of vcn"
  type        = string
}


# availability domains
variable "availability_domains" {
  description = "Availability Domains where to provision non-OKE resources"
  default = {
    db       = 1
  }
  type = map(any)
}

## Allowed cidrs and ports for load balancers

## waf
variable "enable_waf" {
  description = "Whether to enable WAF monitoring of load balancers"
  type        = bool
  default     = false
}


variable "load_balancers" {
  # values: both, internal, public
  default     = "public"
  description = "The type of subnets to create for load balancers."
  type        = string
  validation {
    condition     = contains(["public", "internal", "both"], var.load_balancers)
    error_message = "Accepted values are public, internal or both."
  }
}

variable "internal_lb_allowed_cidrs" {
  default     = ["0.0.0.0/0"]
  description = "The list of CIDR blocks from which the internal load balancer can be accessed."
  type        = list(string)

  validation {
    condition     = length(var.internal_lb_allowed_cidrs) > 0
    error_message = "At least 1 CIDR block is required."
  }
}

variable "internal_lb_allowed_ports" {
  default     = [80, 443]
  description = "List of allowed ports for internal load balancers."
  type        = list(any)

  validation {
    condition     = length(var.internal_lb_allowed_ports) > 0
    error_message = "At least 1 port is required."
  }
}

variable "public_lb_allowed_cidrs" {
  default     = ["0.0.0.0/0"]
  description = "The list of CIDR blocks from which the public load balancer can be accessed."
  type        = list(string)

  validation {
    condition     = length(var.public_lb_allowed_cidrs) > 0
    error_message = "At least 1 CIDR block is required."
  }
}

variable "public_lb_allowed_ports" {
  default     = [443]
  description = "List of allowed ports for public load balancers."
  type        = list(any)

  validation {
    condition     = length(var.public_lb_allowed_ports) > 0
    error_message = "At least 1 port is required."
  }
}


# ocir

variable "email_address" {
  default     = "none"
  description = "The email address used for OCIR."
  type        = string
}

variable "secret_id" {
  description = "The OCID of the Secret on OCI Vault which holds the authentication token."
  type        = string
  default     = "none"
}

variable "secret_name" {
  description = "The name of the Kubernetes secret that will hold the authentication token"
  type        = string
  default     = "ocirsecret"
}

variable "secret_namespace" {
  default     = "default"
  description = "The Kubernetes namespace for where the OCIR secret will be created."
  type        = string
}

variable "username" {
  default     = "none"
  description = "The username that can login to the selected tenancy. This is different from tenancy_id. *Required* if secret_id is set."
  type        = string
}

# tagging
variable "freeform_tags" {
  default = {
    # vcn, bastion and operator tags are required
    # add more tags in each as desired
    vcn = {
      environment = "dev"
    },
    objectstorage = {
      environment = "dev"
      entity        = "appdev"
    }
  }
  description = "Tags to apply to different resources."
  type = object({
    vcn      = map(any)
    /* bastion  = map(any),
    operator = map(any),
    oke      = map(map(any)) */
  })
}

# Storage - Object Storage

variable "bucket_name" {
  default     = "none"
  description = "Bucket name in object storage"
  type        = string
}

variable "bucket_namespace" {
  default     = "none"
  description = "Bucket namespace in object storage"
  type        = string
}

variable "bucket_object_events_enabled" {
  default     = false
  description = "Bucket events on activity in object storage"
  type        = bool
}

variable "bucket_versioning" {
  default     = "none"
  description = "Bucket versioning in object storage"
  type        = string
}



# ADB - DW

# Variables

variable "db_name"        { type = string }
variable "admin_password" { type = string }
variable "db_version"     { type = string }
# OLTP, DW, AJD, APEX
variable "db_workload"    { type = string }
# Must be false for AJD and APEX
variable "is_free_tier"   { type = string }
# BRING_YOUR_OWN_LICENSE or LICENSE_INCLUDED
variable "license_model"  { type = string }

variable "cpu_core_count" {
  type    = number
  default = 1
}