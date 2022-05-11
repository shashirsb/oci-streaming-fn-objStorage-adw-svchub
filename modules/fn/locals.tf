# OCIR repo name & namespace

locals {
  app_name_lower         = lower(var.application_names)
  ocir_repo_name         = var.ocir_repo_name            
  ocir_docker_repository = join("", [lower("phx"), ".ocir.io"])
  ocir_namespace         = lookup(data.oci_objectstorage_namespace.os_namespace, "namespace")
}