variable "lambda_sigv4_name" {
  description = "Name of the lambda function that will return the Sigv4 headers"
  default     = "aws-lambda-signer"

  type = string
}

variable "sigv4_config" {
  description = "Map of request configuration, must contain create & destroy maps"

  type = map(any)

  default = {
    request_1 = {
      create  = {}
      destroy = {}
    }
  }
}

variable "sigv4_modify_config" {
  description = "Map of request configuration for to modify resources"
  type        = map(any)

  default = {
    request_1 = {
      modify = {}
    }
  }
}
