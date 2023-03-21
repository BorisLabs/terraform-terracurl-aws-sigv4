variable "lambda_function_name" {
  description = "Name of the lambda function that will return the Sigv4 headers"
  default     = "aws-lambda-signer"

  type = string
}

variable "aws_request_config" {
  description = "Map of request configuration, needs to contain create keys as a minimum. Destroy keys dont need to be included, however this will leave orphaned resources"

  type = map(any)

  default = {
    request_1 = {
      create  = {}
      destroy = {}
    }
  }
}
