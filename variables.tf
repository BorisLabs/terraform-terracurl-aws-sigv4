variable "lambda_function_name" {
  description = "Name of the lambda function that will return the Sigv4 headers"
  default     = "aws-lambda-signer"

  type = string
}

variable "aws_request_config" {
  description = "List object with details of Configuration paramters"
  default     = []

  type = list(object({
    name    = string
    url     = string
    region  = string
    service = string
    create = object({
      response_codes = list(string)
      method         = optional(string)
      headers        = optional(map(string))
      params         = optional(map(string))
      data           = optional(map(string))
    })
    destroy = optional(object({
      response_codes = optional(list(string))
      method         = optional(string)
      headers        = optional(map(string))
      params         = optional(map(string))
      data           = optional(map(string))
    }))
  }))
}
