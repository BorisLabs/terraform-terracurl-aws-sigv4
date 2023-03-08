variable "layer_name" {
  description = "Name of the Lambda Layer"
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
  default = "python"

  type = string
}