variable "layer_name" {
  description = "Name of layer to lookup & use"
  default     = "aws-botocore-sigv4"

  type = string
}

variable "layer_runtime" {
  description = "Runtime version for Layer"
  default     = "python3.9"

  type = string
}

variable "layer_architectures" {
  description = "Runtime architectures"
  default     = ["x86_64"]

  type = list(string)
}

variable "layer_prefix_in_zip_module" {
  description = "Prefix in zip file"
  default     = "python/"

  type = string
}

variable "docker_build_image" {
  description = "Docker image to build layer in"
  default     = "amazon/aws-lambda-python:3.9"

  type = string
}

variable "docker_build_root" {
  description = "Directory within Docker container"
  default     = "/tmp/build"

  type = string
}

variable "function_name" {
  description = "Name of the function that will generate the sign SIGV4 requests"
  default     = "aws-lambda-signer"

  type = string
}

variable "iam_role_name" {
  description = "Name of the IAM role that's created"
  default     = "aws-sigv4-lambda-role"


  type = string
}

variable "iam_policy_name" {
  description = "Name of the IAM Policy to create & attach to the role"
  default     = "aws-sigv4-lambda-policy"

  type = string
}

variable "iam_config" {
  description = "Map of IAM Config to apply to lambda function"
  default     = {}

  type = map(string)
}

variable "json_attach_policies" {
  description = "Attach JSON IAM Policies"
  default     = false

  type = bool
}

variable "json_policies" {
  description = "List of JSON Policies to attach"
  default     = []

  type = list(string)
}

variable "json_policy_count" {
  description = "Count of number of policies in json_policies"
  default     = 0

  type = number
}
