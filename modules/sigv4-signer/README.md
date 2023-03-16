Lambda function to generate a sigv4 signature & use with terracurl. Allows you to interact with AWS APIs. Uses a 
Lambda Layer to install specific botocore, boto3 & awscrt packages. This allows the generation of a SIGV4 signature.

<!-- BEGIN_TF_DOCS -->
## Requirements

No requirements.

## Providers

| Name | Version |
|------|---------|
| <a name="provider_aws"></a> [aws](#provider\_aws) | 4.58.0 |

## Modules

| Name | Source | Version |
|------|--------|---------|
| <a name="module_sigv4_lambda"></a> [sigv4\_lambda](#module\_sigv4\_lambda) | terraform-aws-modules/lambda/aws | 4.10.1 |

## Resources

| Name | Type |
|------|------|
| [aws_lambda_layer_version.existing](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/lambda_layer_version) | data source |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_layer_name"></a> [layer\_name](#input\_layer\_name) | Name of layer to lookup & use | `string` | `"aws-botocore-sigv4"` | no |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_compatible_runtimes"></a> [compatible\_runtimes](#output\_compatible\_runtimes) | n/a |
| <a name="output_layer_arn"></a> [layer\_arn](#output\_layer\_arn) | n/a |
| <a name="output_layer_id"></a> [layer\_id](#output\_layer\_id) | n/a |
<!-- END_TF_DOCS -->