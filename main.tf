locals {
  config = var.aws_request_config
}

locals {
  request_helper = { for k, config in local.config : config.name => {
    config_create = {
      config  = config.create
      url     = config.url
      service = config.service
      region  = config.region
    }
    config_destroy = {
      config  = config.destroy
      url     = config.url
      service = config.service
      region  = config.region
  } } }
}

// Generates a set of SIGV4 requests for create & destory method requests. 
data "aws_lambda_invocation" "sigv4" {
  for_each = local.request_helper

  function_name = var.lambda_function_name
  input         = jsonencode(each.value)
}

// Loop through the config, because we have both Create & Destroy commands this cant use the same map as the lambda
// Each type of Request i.e. Create or Destroy as a different SIGV4 signature generated. 
// This is because the make up of the SIGV4 signature includes body & request parameters plus headers.
// So we use the response from the lambd invocation in the parts that require this.
resource "terracurl_request" "create_and_destroy" {
  for_each = local.request_helper

  name   = each.key
  url    = try(local.request_helper[each.key].config_create["url"], null)
  method = try(local.request_helper[each.key].config_create["config"]["method"], null)

  response_codes = local.request_helper[each.key].config_create["config"]["response_codes"]

  headers            = try(jsondecode(data.aws_lambda_invocation.sigv4[each.key].result)["config_create"]["headers"], null)
  request_body       = try(jsondecode(data.aws_lambda_invocation.sigv4[each.key].result)["config_create"]["data"], null)
  request_parameters = try(jsondecode(data.aws_lambda_invocation.sigv4[each.key].result)["config_create"]["request_params"], null)

  destroy_url    = try(local.request_helper[each.key].config_destroy["url"], null)
  destroy_method = try(local.request_helper[each.key].config_destroy["config"]["method"], null)

  destroy_headers      = try(jsondecode(data.aws_lambda_invocation.sigv4[each.key].result)["config_destroy"]["headers"], null)
  destroy_request_body = try(jsondecode(data.aws_lambda_invocation.sigv4[each.key].result)["config_destroy"]["data"], null)
  destroy_parameters   = try(jsondecode(data.aws_lambda_invocation.sigv4[each.key].result)["config_destroy"]["request_params"], null)

  destroy_response_codes = try(local.request_helper[each.key].config_create["config"]["response_codes"], null)
}
