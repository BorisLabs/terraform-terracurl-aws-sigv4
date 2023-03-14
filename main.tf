locals {
  sigv4_config = var.sigv4_config
}

locals {
  request_helper = flatten([
    for req, config in local.sigv4_config : [
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

  function_name = var.lambda_sigv4_name
  input         = jsonencode(each.value)
}

resource "terracurl_request" "create_and_destroy" {
  for_each = toset(keys(local.sigv4_config))

  name   = each.key
  url    = local.sigv4_config[each.key]["create"]["url"]
  method = local.sigv4_config[each.key]["create"]["method"]

  headers        = jsondecode(data.aws_lambda_invocation.sigv4["${each.key}_create"].result)["headers"]
  response_codes = [200, 400, 403]

  request_body       = jsondecode(data.aws_lambda_invocation.sigv4["${each.key}_create"].result)["data"]
  request_parameters = jsondecode(data.aws_lambda_invocation.sigv4["${each.key}_create"].result)["request_params"]


  destroy_url          = local.sigv4_config[each.key]["destroy"]["url"]
  destroy_method       = local.sigv4_config[each.key]["create"]["method"]
  destroy_headers      = jsondecode(data.aws_lambda_invocation.sigv4["${each.key}_destroy"].result)["headers"]
  destroy_request_body = jsondecode(data.aws_lambda_invocation.sigv4["${each.key}_destroy"].result)["data"]
  destroy_parameters   = jsondecode(data.aws_lambda_invocation.sigv4["${each.key}_destroy"].result)["request_params"]

  destroy_response_codes = [200, 400, 403]

  lifecycle {
    ignore_changes = all
  }
}
