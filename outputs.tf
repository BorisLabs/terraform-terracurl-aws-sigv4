output "local_config" {
  value = local.sigv4_config
}

output "sigv4_config" {
  value = { for k, v in data.aws_lambda_invocation.sigv4 : k => v }
}

output "status_code" {
  value = flatten([
    for k, v in terracurl_request.create_and_destroy : [
    for d, value in v : { "${k}" = value } if d == "status_code"]
  ])
}

output "request_url" {
  value = [
    for k, v in terracurl_request.create_and_destroy : [
    for d, value in v : { "${k}" = value } if d == "request_url_string"]
  ]
}

output "response" {
  value = flatten([
    for k, v in terracurl_request.create_and_destroy : [
    for d, value in v : { "${k}" = value } if d == "response"]
  ])
}
