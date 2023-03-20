terraform {
  required_providers {
    terracurl = {
      source  = "devops-rob/terracurl"
      version = ">= 1.1.0"
    }
    aws = {
      source  = "hashicorp/aws"
      version = ">= 4.59.0"
    }
  }
}
