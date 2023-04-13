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

  aws_request_config = [
    {
      name    = "TerraformGroup"
      service = "iam"
      region  = "us-east-1"
      method  = "POST"
      url     = "https://iam.amazonaws.com"
      create = {
        response_codes = [200, 403, 404]
        method         = "POST"
        headers = {
          Content-Type = "application/x-amz-json-1.1"
        }
        data = {}
        params = {
          Action    = "CreateGroup",
          GroupName = "TerraformGroup",
          Version   = "2010-05-08"

        }
      }
      destroy = {
        method  = "POST"
        headers = {}
        data = {
          Content-Type = "application/x-amz-json-1.1"
        }
        params = {
          Action    = "DeleteGroup",
          GroupName = "TerraformGroup",
          Version   = "2010-05-08"
        }
      }
    },
    {
      name    = "ecs_group"
      service = "iam"
      region  = "us-east-1"
      url     = "https://iam.amazonaws.com"
      create = {
        method         = "POST"
        response_codes = [200, 403, 404]
        headers = {
          Content-Type = "application/x-amz-json-1.1"
        }
        data = {}
        params = {
          Action    = "CreateGroup",
          GroupName = "ECSGroup",
          Version   = "2010-05-08"
        }
      }
      destroy = {
        method = "POST"
        headers = {
          Content-Type = "application/x-amz-json-1.1"
        }
        data = {}
        params = {
          Action    = "DeleteGroup",
          GroupName = "ECSGroup",
          Version   = "2010-05-08"
        }
      }
    }
  ]
}

output "response" {
  value = module.iam_group.response
}

output "request_url" {
  value = module.iam_group.request_url
}

output "status_code" {
  value = module.iam_group.status_code
}
