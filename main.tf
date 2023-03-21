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

data "aws_lambda_invocation" "sigv4" {
  for_each = { for d in local.request_helper : d.name => d.config }

  function_name = var.lambda_function_name
  input         = jsonencode(each.value)
}

resource "terracurl_request" "create_and_destroy" {
  for_each = toset(keys(local.config))

  name   = each.key
  url    = local.config[each.key]["create"]["url"]
  method = local.config[each.key]["create"]["method"]

  response_codes = [200, 400, 403]

  headers            = jsondecode(data.aws_lambda_invocation.sigv4["${each.key}_create"].result)["headers"]
  request_body       = jsondecode(data.aws_lambda_invocation.sigv4["${each.key}_create"].result)["data"]
  request_parameters = jsondecode(data.aws_lambda_invocation.sigv4["${each.key}_create"].result)["request_params"]


  destroy_url          = local.config[each.key]["destroy"]["url"]
  destroy_method       = local.config[each.key]["destroy"]["method"]
  destroy_headers      = jsondecode(data.aws_lambda_invocation.sigv4["${each.key}_destroy"].result)["headers"]
  destroy_request_body = jsondecode(data.aws_lambda_invocation.sigv4["${each.key}_destroy"].result)["data"]
  destroy_parameters   = jsondecode(data.aws_lambda_invocation.sigv4["${each.key}_destroy"].result)["request_params"]

  destroy_response_codes = [200, 400, 403]

  lifecycle {
    ignore_changes = all
  }
}
