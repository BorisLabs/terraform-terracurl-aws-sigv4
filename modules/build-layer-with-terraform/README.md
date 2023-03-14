<!-- BEGIN_TF_DOCS -->
## Requirements

No requirements.

## Providers

No providers.

## Modules

| Name | Source | Version |
|------|--------|---------|
| <a name="module_build_sigv4_botocore_layer"></a> [build\_sigv4\_botocore\_layer](#module\_build\_sigv4\_botocore\_layer) | terraform-aws-modules/lambda/aws | 4.10.1 |

## Resources

No resources.

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_layer_architectures"></a> [layer\_architectures](#input\_layer\_architectures) | Runtime architectures | `list(string)` | <pre>[<br>  "x86_64"<br>]</pre> | no |
| <a name="input_layer_name"></a> [layer\_name](#input\_layer\_name) | Name of the Lambda Layer | `string` | `"aws-botocore-sigv4"` | no |
| <a name="input_layer_prefix_in_zip_module"></a> [layer\_prefix\_in\_zip\_module](#input\_layer\_prefix\_in\_zip\_module) | Prefix in zip file | `string` | `"python"` | no |
| <a name="input_layer_runtime"></a> [layer\_runtime](#input\_layer\_runtime) | Runtime version for Layer | `string` | `"python3.9"` | no |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_layer_arn"></a> [layer\_arn](#output\_layer\_arn) | n/a |
| <a name="output_layer_version"></a> [layer\_version](#output\_layer\_version) | n/a |
<!-- END_TF_DOCS -->