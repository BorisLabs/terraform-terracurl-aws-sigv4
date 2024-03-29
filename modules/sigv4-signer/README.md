Lambda function to generate a sigv4 signature & use with terracurl. Allows you to interact with AWS APIs. Uses a 
Lambda Layer to install specific botocore, boto3 & awscrt packages. This allows the generation of a SIGV4 signature.

<!-- BEGIN_TF_DOCS -->
## Requirements

No requirements.

## Providers

No providers.

## Modules

| Name | Source | Version |
|------|--------|---------|
| <a name="module_build_sigv4_botocore_layer"></a> [build\_sigv4\_botocore\_layer](#module\_build\_sigv4\_botocore\_layer) | terraform-aws-modules/lambda/aws | 4.10.1 |
| <a name="module_sigv4_lambda"></a> [sigv4\_lambda](#module\_sigv4\_lambda) | terraform-aws-modules/lambda/aws | 4.10.1 |

## Resources

No resources.

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_docker_build_image"></a> [docker\_build\_image](#input\_docker\_build\_image) | Docker image to build layer in | `string` | `"amazon/aws-lambda-python:3.9"` | no |
| <a name="input_docker_build_root"></a> [docker\_build\_root](#input\_docker\_build\_root) | Directory within Docker container | `string` | `"/tmp/build"` | no |
| <a name="input_function_name"></a> [function\_name](#input\_function\_name) | Name of the function that will generate the sign SIGV4 requests | `string` | `"aws-lambda-signer"` | no |
| <a name="input_iam_config"></a> [iam\_config](#input\_iam\_config) | Map of IAM Config to apply to lambda function | `map(string)` | `{}` | no |
| <a name="input_iam_policy_name"></a> [iam\_policy\_name](#input\_iam\_policy\_name) | Name of the IAM Policy to create & attach to the role | `string` | `"aws-sigv4-lambda-policy"` | no |
| <a name="input_iam_role_name"></a> [iam\_role\_name](#input\_iam\_role\_name) | Name of the IAM role that's created | `string` | `"aws-sigv4-lambda-role"` | no |
| <a name="input_json_attach_policies"></a> [json\_attach\_policies](#input\_json\_attach\_policies) | Attach JSON IAM Policies | `bool` | `false` | no |
| <a name="input_json_policies"></a> [json\_policies](#input\_json\_policies) | List of JSON Policies to attach | `list(string)` | `[]` | no |
| <a name="input_json_policy_count"></a> [json\_policy\_count](#input\_json\_policy\_count) | Count of number of policies in json\_policies | `number` | `0` | no |
| <a name="input_layer_architectures"></a> [layer\_architectures](#input\_layer\_architectures) | Runtime architectures | `list(string)` | <pre>[<br>  "x86_64"<br>]</pre> | no |
| <a name="input_layer_name"></a> [layer\_name](#input\_layer\_name) | Name of layer to lookup & use | `string` | `"aws-botocore-sigv4"` | no |
| <a name="input_layer_prefix_in_zip_module"></a> [layer\_prefix\_in\_zip\_module](#input\_layer\_prefix\_in\_zip\_module) | Prefix in zip file | `string` | `"python/"` | no |
| <a name="input_layer_runtime"></a> [layer\_runtime](#input\_layer\_runtime) | Runtime version for Layer | `string` | `"python3.9"` | no |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_lambda_function_arn"></a> [lambda\_function\_arn](#output\_lambda\_function\_arn) | n/a |
| <a name="output_layer_arn"></a> [layer\_arn](#output\_layer\_arn) | n/a |
| <a name="output_layer_version"></a> [layer\_version](#output\_layer\_version) | n/a |
<!-- END_TF_DOCS -->