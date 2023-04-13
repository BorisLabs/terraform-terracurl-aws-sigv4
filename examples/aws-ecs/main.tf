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

module "ecs_cluster" {
  source = "../../"

  lambda_function_name = "aws-lambda-signer"

  aws_request_config = [
    {
      name    = "ecs-cluster"
      service = "ecs"
      region  = "eu-west-1"
      url     = "https://ecs.eu-west-1.amazonaws.com"
      create = {
        response_codes = [200, 400, 403]
        method         = "POST"
        headers = {
          Accept-Encoding = "identity"
          Content-Type    = "application/x-amz-json-1.1"
          X-Amz-Target    = "AmazonEC2ContainerServiceV20141113.CreateCluster"
        }
        data = {
          "clusterName" = "RobsClusterAPI-v2"
        }
        params = {
          "Action" = "CreateCluster"
        }
      }
      destroy = {
        response_codes = [200, 400, 403]
        method         = "POST"
        headers = {
          Accept-Encoding = "identity"
          Content-Type    = "application/x-amz-json-1.1"
          X-Amz-Target    = "AmazonEC2ContainerServiceV20141113.DeleteCluster"
        }
        data = {
          "cluster" = "RobsClusterAPI-v2"
        }
        params = {
          "Action" = "DeleteCluster"
        }
      }
    }
  ]
}


output "request" {
  value = module.ecs_cluster
}
