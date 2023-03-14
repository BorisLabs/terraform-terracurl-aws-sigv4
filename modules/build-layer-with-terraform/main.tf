provider "aws" {
  region = "eu-west-1"
}

module "build_sigv4_botocore_layer" {
  source  = "terraform-aws-modules/lambda/aws"
  version = "4.10.1"

  create_function = false
  create_layer    = true

  layer_name          = var.layer_name
  compatible_runtimes = [var.layer_runtime]
  runtime             = var.layer_runtime # required to force layers to do pip install

  compatible_architectures = var.layer_architectures

  source_path = [
    {
      prefix_in_zip    = var.layer_prefix_in_zip_module # required to get the path correct
      pip_requirements = "${path.module}/requirements/requirements.txt"
    }
  ]
}

output "layer_arn" {
  value = module.build_sigv4_botocore_layer.lambda_layer_arn
}

output "layer_version" {
  value = module.build_sigv4_botocore_layer.lambda_layer_version
}
