provider "aws" {
  region = "eu-west-1"
}

data "aws_lambda_layer_version" "this" {
  layer_name = "aws-botocore-sigv4"
}

module "build_lambda" {
  source = "terraform-aws-modules/lambda/aws"

  create_function = true
  function_name   = "sigv-validate"

  handler = "main.lambda_handler"

  create_role = true
  role_name   = "layer-validator"
  policy_name = "layer-policy"

  runtime = "python3.9"
  source_path = [{
    path = "src/"
  }]

  layers = [
    data.aws_lambda_layer_version.this.arn
  ]

  artifacts_dir = "${path.root}/builds/package_dir_pip_dir/"
}

data "aws_lambda_invocation" "validate" {

  depends_on = [
    module.build_lambda
  ]
  function_name = module.build_lambda.lambda_function_name

  input = <<JSON
{
  "key1": "value1",
  "key2": "value2"
}
JSON
}


// The output shouuld be the versions of boto3 / botocore & if the auth package is available
output "validation" {
  value = jsondecode(data.aws_lambda_invocation.validate.result)
}
