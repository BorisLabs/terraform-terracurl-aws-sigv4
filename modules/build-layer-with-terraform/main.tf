provider "aws" {
  region = "eu-west-1"
}

module "lambda_layer_pip_requirements" {
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
      pip_requirements = true
      prefix_in_zip    = var.layer_prefix_in_zip_module # required to get the path correct
      pip_requirements = "${path.module}/requirements/requirements.txt"
    }
  ]
}
