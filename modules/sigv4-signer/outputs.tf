output "layer_arn" {
  value = module.build_sigv4_botocore_layer.lambda_layer_arn
}

output "layer_version" {
  value = module.build_sigv4_botocore_layer.lambda_layer_version
}

output "lambda_function_arn" {
  value = module.sigv4_lambda.lambda_function_arn
}
