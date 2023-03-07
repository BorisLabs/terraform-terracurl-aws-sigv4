output "local_config" {
  value = local.sigv4_config
}

output "sigv4_config" {
  value = data.aws_lambda_invocation.sigv4
}

output "status_code" {
  value = terracurl_request.create_and_destroy
}

output "request_url" {
  value = terracurl_request.create_and_destroy
}

output "response" {
  value = terracurl_request.create_and_destroy
}
