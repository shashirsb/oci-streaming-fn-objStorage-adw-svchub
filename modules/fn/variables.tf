variable "tenancy_id" {}
variable "compartment_id" {}
variable "label_prefix" {}
variable "freeform_tags" {}

variable "ocir_user_name" { default = "define the username for the OCIR repos"}
variable "ocir_user_password" {
    default = "password for OCIR repos"
    sensitive = true
    }

variable "application_names" { type = list(string) }

variable "function_names" { type = list(string) }

variable "test_invoke_function_body"  {
  default = "{\"name\": \"Brave New World\"}"
} 

variable "region" {
    type = string
}

variable "ocir_repo_name" { type = list(string) }

variable "cluster_subnets" {
  type = map(any)
}



