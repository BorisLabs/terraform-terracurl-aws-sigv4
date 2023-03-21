locals {
  config = var.aws_request_config
}

locals {
  request_helper = flatten([
    for req, config in local.config : [
      for rt, d in config : {
        name   = "${req}_${d.mode}"
        config = d
      }
    ]
    ]
  )
}

// Generates a set of SIGV4 requests for create & destory methods request. 
data "aws_lambda_invocation" "sigv4" {
  for_each = { for d in local.request_helper : d.name => d.config }

  function_name = var.lambda_function_name
  input         = jsonencode(each.value)
}

// Loop through the config, because we have both Create & Destroy commands this cant use the same map as the lambda
// Each type of Request i.e. Create or Destroy as a different SIGV4 signature generated. 
// This is because the make up of the SIGV4 signature includes body & request parameters plus headers.
// So we use the response from the lambd invocation in the parts that require this.
resource "terracurl_request" "create_and_destroy" {
  for_each = toset(keys(local.config))

  name   = each.key
  url    = try(local.config[each.key]["create"]["url"], null)
  method = try(local.config[each.key]["create"]["method"], null)

  response_codes = [200, 400, 403]

  headers            = try(jsondecode(data.aws_lambda_invocation.sigv4["${each.key}_create"].result)["headers"], null)
  request_body       = try(jsondecode(data.aws_lambda_invocation.sigv4["${each.key}_create"].result)["data"], null)
  request_parameters = try(jsondecode(data.aws_lambda_invocation.sigv4["${each.key}_create"].result)["request_params"], null)

  destroy_url          = try(local.config[each.key]["destroy"]["url"], null)
  destroy_method       = try(local.config[each.key]["destroy"]["method"], null)
  destroy_headers      = try(jsondecode(data.aws_lambda_invocation.sigv4["${each.key}_destroy"].result)["headers"], null)
  destroy_request_body = try(jsondecode(data.aws_lambda_invocation.sigv4["${each.key}_destroy"].result)["data"], null)
  destroy_parameters   = try(jsondecode(data.aws_lambda_invocation.sigv4["${each.key}_destroy"].result)["request_params"], null)

  destroy_response_codes = contains(keys(local.config[each.key]), "destroy") ? [200, 400, 403] : null

  // This is just a create & destroy method, any modifications to the resource will result in a different API call.
  // Which in turn results in a different SIGV4 authorization request. But terracurl only supports Create / Destroy.
  // So this resource will ignore any changes, there's potential for a modification resource. But I suspect that may be get messy. 
  // Although if you control the ordering of the map sent in, you could modify the resource after Creation call.
  lifecycle {
    ignore_changes = all
  }
}
