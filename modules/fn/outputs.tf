output "function_response" {
  value = oci_functions_invoke_function.test_invoke_new_function.content
}