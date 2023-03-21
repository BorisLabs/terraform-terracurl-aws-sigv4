provider "aws" {
  region = "eu-west-1"
}

locals {
  iam_configuration = var.iam_config
}

module "build_sigv4_botocore_layer" {
  source  = "terraform-aws-modules/lambda/aws"
  version = "4.10.1"

  create_function = false
  create_layer    = true

  build_in_docker   = true
  docker_image      = var.docker_build_image
  docker_build_root = var.docker_build_root

  layer_name          = var.layer_name
  compatible_runtimes = [var.layer_runtime]
  runtime             = var.layer_runtime # required to force layers to do pip install

  compatible_architectures = var.layer_architectures

  source_path = [
    {
      prefix_in_zip    = "python" # required to get the path correct
      pip_requirements = "${path.module}/requirements/requirements.txt"
    }
  ]
}

module "sigv4_lambda" {
  source  = "terraform-aws-modules/lambda/aws"
  version = "4.10.1"

  create_function = true

  function_name = var.function_name
  handler       = "lambda_handler.lambda_handler"

  create_role = true

  role_name   = var.iam_role_name
  policy_name = var.iam_policy_name

  attach_policy_jsons    = var.json_attach_policies
  policy_jsons           = var.json_policies
  number_of_policy_jsons = var.json_policy_count

  compatible_runtimes = [var.layer_runtime]
  runtime             = var.layer_runtime # required to force layers to do pip install

  compatible_architectures = var.layer_architectures

  layers = [
    module.build_sigv4_botocore_layer.lambda_layer_arn
  ]

  source_path = [{
    path = "${path.module}/src/"
  }]
}
