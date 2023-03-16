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

