provider "aws" {
  region = "eu-west-1"
}

provider "terracurl" {
}

terraform {
  required_providers {
    terracurl = {
      source = "devops-rob/terracurl"
    }
  }
}

module "iam_group" {
  source = "../../"

  sigv4_config = {
    terraform_group = {
      create = {
        mode    = "create"
        service = "iam"
        region  = "us-east-1"
        method  = "POST"
        url     = "https://iam.amazonaws.com"
        headers = {}
        data    = {}
        params = {
          Action    = "CreateGroup",
          GroupName = "TerraformGroup",
          Version   = "2010-05-08"
        }
      }
      destroy = {
        mode    = "destroy"
        service = "iam"
        region  = "us-east-1"
        method  = "POST"
        url     = "https://iam.amazonaws.com"
        headers = {}
        data    = {}
        params = {
          Action    = "DeleteGroup",
          GroupName = "TerraformGroup",
          Version   = "2010-05-08"
        }
      }
    }
    ecs_group = {
      create = {
        mode    = "create"
        service = "iam"
        region  = "us-east-1"
        method  = "POST"
        url     = "https://iam.amazonaws.com"
        headers = {}
        data    = {}
        params = {
          Action    = "CreateGroup",
          GroupName = "ECSGroup",
          Version   = "2010-05-08"
        }
      }
      destroy = {
        mode    = "destroy"
        service = "iam"
        region  = "us-east-1"
        method  = "POST"
        url     = "https://iam.amazonaws.com"
        headers = {}
        data    = {}
        params = {
          Action    = "DeleteGroup",
          GroupName = "ECSGroup",
          Version   = "2010-05-08"
        }
      }
    }
  }
}

output "response" {
  value = module.iam_group.response
}

output "request_url" {
  value = module.iam_group.request_url
}

output "signed_response" {
  value = module.iam_group.sigv4_config
}

output "status_code" {
  value = module.iam_group.status_code
}
