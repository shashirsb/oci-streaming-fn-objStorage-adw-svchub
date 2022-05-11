output "function_response" {
  value = oci_functions_invoke_function.test_invoke_new_function.content
}

output "function_response_push2stream" {
  value = oci_functions_invoke_function.test_invoke_new_function_push2stream.content
}