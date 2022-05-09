variable "compartment_id" {}
variable "label_prefix" {}
variable "freeform_tags" {}

variable "ocir_user_name" { default = "define the username for the OCIR repos"}
variable "ocir_user_password" {
    default = "password for OCIR repos"
    sensitive = true
    }

variable "application_name" {
  default = "cloudnative-2021App"
}

variable "function_name" {
  default = "my-new-function"
}

variable "test_invoke_function_body"  {
  default = "{\"name\": \"Brave New World\"}"
} 

variable "ocir_docker_repository" {
    type = string
}

