resource "oci_functions_application" "FnApp" {
    compartment_id = var.compartment_id
    display_name = "${local.app_name_lower}"
    subnet_ids = [var.cluster_subnets["db"]]
}

### Repository in the Container Image Registry for the container images underpinning the function 
resource "oci_artifacts_container_repository" "container_repository_for_function" {
    # note: repository = store for all images versions of a specific container image - so it included the function name
    depends_on = [ oci_functions_application.FnApp]
    compartment_id = var.compartment_id
    display_name = "${var.ocir_repo_name}/${var.function_name}"
    is_immutable = false
    is_public = false
}

resource "null_resource" "Login2OCIR" {
  depends_on = [ oci_artifacts_container_repository.container_repository_for_function]

  provisioner "local-exec" {
    command = "echo '${var.ocir_user_password}' |  docker login ${local.ocir_docker_repository} --username ${local.ocir_namespace}/${var.ocir_user_name} --password-stdin"
  }
}



### build the function into a container image and push that image to the repository in the OCI Container Image Registry
resource "null_resource" "FnPush2OCIR" {
  depends_on = [null_resource.Login2OCIR, oci_artifacts_container_repository.container_repository_for_function]

  # remove function image (if it exists) from local container registry
  provisioner "local-exec" {
    command     = "image=$(docker images | grep ${local.app_name_lower} | awk -F ' ' '{print $3}') ; docker rmi -f $image &> /dev/null ; echo $image"
    working_dir = "modules/fn/functions/fake-fun"
  }

  # remove fake-fun image  (if it exists) from local container registry
  provisioner "local-exec" {
    command     = "image=$(docker images | grep fake-fun | awk -F ' ' '{print $3}') ; docker rmi -f $image &> /dev/null ; echo $image"
    working_dir = "modules/fn/functions/fake-fun"
  }

  # build the function; this results in an image called fake-fun (because of the name attribnute in the func.yaml file)
  provisioner "local-exec" {
    command     = "fn build --verbose"
    working_dir = "modules/fn/functions/fake-fun"
  }

  # tag the container image with the proper name - based on the actual name of the function
  provisioner "local-exec" {
    command     = "image=$(docker images | grep fake-fun | awk -F ' ' '{print $3}') ; docker tag $image ${local.ocir_docker_repository}/${local.ocir_namespace}/${var.ocir_repo_name}/${var.function_name}:0.0.1"
    working_dir = "modules/fn/functions/fake-fun"
  }

  # create a container image based on fake-fun (hello world), tagged for the designated function name 
  provisioner "local-exec" {
    command     = "docker push ${local.ocir_docker_repository}/${local.ocir_namespace}/${var.ocir_repo_name}/${var.function_name}:0.0.1"
    working_dir = "modules/fn/functions/fake-fun"
  }

}



resource "oci_functions_function" "new_function" {
  depends_on     = [null_resource.Login2OCIR]
  application_id = oci_functions_application.FnApp.id
  display_name   = "${var.function_name}"
  //image          = "${local.ocir_docker_repository}/${local.ocir_namespace}/${var.ocir_repo_name}/${var.function_name}:0.0.1"
  image          = "fedbank/functions/my-new-function:0.0.1"
  memory_in_mbs  = "128"
  config = tomap({
    DUMMY_CONFIG_PARAM = "no value required"
  })
}

### wait a little while before the function is ready to be invoked
## I got the following errors without this wait introduced into the plan 
## Error: 404-NotAuthorizedOrNotFound 
## Error Message: Authorization failed or requested resource not found 
##│Suggestion: Either the resource has been deleted or service Functions Invoke Function need policy to access this resource. 
resource "time_sleep" "wait_for_function_to_be_ready" {
  depends_on = [oci_functions_function.new_function]
  create_duration = "15s"
}

resource "oci_functions_invoke_function" "test_invoke_new_function" {
  depends_on     = [time_sleep.wait_for_function_to_be_ready]
    #Required
    function_id = oci_functions_function.new_function.id

    #Optional
    invoke_function_body = var.test_invoke_function_body
    fn_intent = "httprequest"
    fn_invoke_type = "sync" 
    base64_encode_content = false
}

output "function_response" {
  value = oci_functions_invoke_function.test_invoke_new_function.content
}