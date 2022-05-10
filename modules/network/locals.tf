# Copyright 2017, 2021 Oracle Corporation and/or affiliates.
# Licensed under the Universal Permissive License v 1.0 as shown at https://oss.oracle.com/licenses/upl

locals {

  # first vcn cidr
  # pick the first cidr block in the list as this is where we will create the oke subnets
  vcn_cidr = element(data.oci_core_vcn.vcn.cidr_blocks, 0)

  # subnet cidrs - used by subnets

  int_lb_subnet = cidrsubnet(local.vcn_cidr, lookup(var.subnets["int_lb"], "newbits"), lookup(var.subnets["int_lb"], "netnum"))

  pub_lb_subnet = cidrsubnet(local.vcn_cidr, lookup(var.subnets["pub_lb"], "newbits"), lookup(var.subnets["pub_lb"], "netnum"))

  db_subnet = cidrsubnet(local.vcn_cidr, lookup(var.subnets["db"], "newbits"), lookup(var.subnets["db"], "netnum"))

  anywhere = "0.0.0.0/0"

  # port numbers
  health_check_port = 10256
  node_port_min     = 30000
  node_port_max     = 32767

  ssh_port = 22

  # protocols
  # # special OCI value for all protocols
  all_protocols = "all"

  # # IANA protocol numbers
  icmp_protocol = 1

  tcp_protocol = 6

  udp_protocol = 17

  # oracle services network
  osn = lookup(data.oci_core_services.all_oci_services.services[0], "cidr_block")

  # if waf is enabled, construct a list of WAF cidrs
  # else return an empty list
  waf_cidr_list = var.enable_waf == true ? [
    for waf_subnet in data.oci_waas_edge_subnets.waf_cidr_blocks[0].edge_subnets :
    waf_subnet.cidr
  ] : []

  # if port = -1, allow all ports

 


  # Combine supplied allow list and the public load balancer subnet
  internal_lb_allowed_cidrs = concat(var.internal_lb_allowed_cidrs, tolist([local.pub_lb_subnet]))

  # Create a Cartesian product of allowed cidrs and ports
  internal_lb_allowed_cidrs_and_ports = setproduct(local.internal_lb_allowed_cidrs, var.internal_lb_allowed_ports)

  pub_lb_egress = [
    {
      description      = "Allow stateful egress to internal load balancers subnet on port 80",
      destination      = local.int_lb_subnet,
      destination_type = "CIDR_BLOCK",
      protocol         = local.tcp_protocol,
      port             = 80
      stateless        = false
    },
    {
      description      = "Allow stateful egress to internal load balancers subnet on port 443",
      destination      = local.int_lb_subnet,
      destination_type = "CIDR_BLOCK",
      protocol         = local.tcp_protocol,
      port             = 443
      stateless        = false
    }
  ]

  public_lb_allowed_cidrs           = var.public_lb_allowed_cidrs
  public_lb_allowed_cidrs_and_ports = setproduct(local.public_lb_allowed_cidrs, var.public_lb_allowed_ports)



  # db - defined but not used

 db_ingress_seclist = [
    {
      description = "Allow fn host to accept ssh request .",
      protocol    = local.all_protocols,
      port        = -1,
      source      = "0.0.0.0/0",
      source_type = "CIDR_BLOCK",
      stateless   = false
    },
  ]

  db_port = 1521


} 

