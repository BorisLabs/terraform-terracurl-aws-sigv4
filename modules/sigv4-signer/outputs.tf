output "layer_arn" {
  value = module.build_sigv4_botocore_layer.lambda_layer_arn
}

output "layer_version" {
  value = module.build_sigv4_botocore_layer.lambda_layer_version
}
