***NOTE Work in progress ***

# terraform-terracurl-aws-sigv4
Terraform module that uses the AWS & terracurl providers, it allows you to interact with the AWS APIs nativley in terraform.

### Use case:
When the AWS provider doesn't support an AWS Service or as missing functionality, you can still interact with AWS using the terracurl provider.

This module uses a lambda function to generate the required SIGV4 signature & then uses the terracurl provider to call the AWS APIs.

<!-- BEGIN_TF_DOCS -->
## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_aws"></a> [aws](#requirement\_aws) | >= 4.59.0 |
| <a name="requirement_terracurl"></a> [terracurl](#requirement\_terracurl) | >= 1.1.0 |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_aws"></a> [aws](#provider\_aws) | 4.59.0 |
| <a name="provider_terracurl"></a> [terracurl](#provider\_terracurl) | 1.1.0 |

## Modules

No modules.

## Resources

| Name | Type |
|------|------|
| [terracurl_request.create_and_destroy](https://registry.terraform.io/providers/devops-rob/terracurl/latest/docs/resources/request) | resource |
| [aws_lambda_invocation.sigv4](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/lambda_invocation) | data source |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_aws_request_config"></a> [aws\_request\_config](#input\_aws\_request\_config) | Map of request configuration, needs to contain create keys as a minimum. Destroy keys dont need to be included, however this will leave orphaned resources | `map(any)` | <pre>{<br>  "request_1": {<br>    "create": {},<br>    "destroy": {}<br>  }<br>}</pre> | no |
| <a name="input_lambda_function_name"></a> [lambda\_function\_name](#input\_lambda\_function\_name) | Name of the lambda function that will return the Sigv4 headers | `string` | `"aws-lambda-signer"` | no |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_local_config"></a> [local\_config](#output\_local\_config) | n/a |
| <a name="output_request_url"></a> [request\_url](#output\_request\_url) | n/a |
| <a name="output_response"></a> [response](#output\_response) | n/a |
| <a name="output_sigv4_config"></a> [sigv4\_config](#output\_sigv4\_config) | n/a |
| <a name="output_status_code"></a> [status\_code](#output\_status\_code) | n/a |
<!-- END_TF_DOCS -->