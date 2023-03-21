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

  aws_request_config = {
    ecs_cluster = {
      create = {
        mode    = "create"
        service = "ecs"
        region  = "eu-west-1"
        method  = "POST"
        url     = "https://ecs.eu-west-1.amazonaws.com"
        headers = {
          Accept-Encoding = "identity"
          Content-Type    = "application/x-amz-json-1.1"
          X-Amz-Target    = "AmazonEC2ContainerServiceV20141113.CreateCluster"
        }
        data = {
          "clusterName" = "RobsClusterAPI"
        }
        params = {
          "Action" = "CreateCluster"
        }
      }
      destroy = {
        mode    = "destroy"
        service = "ecs"
        region  = "eu-west-1"
        method  = "POST"
        url     = "https://ecs.eu-west-1.amazonaws.com"
        headers = {
          Accept-Encoding = "identity"
          Content-Type    = "application/x-amz-json-1.1"
          X-Amz-Target    = "AmazonEC2ContainerServiceV20141113.DeleteCluster"
        }
        data = {
          "cluster" = "RobsClusterAPI"
        }
        params = {
          "Action" = "DeleteCluster"
        }
      }
    }
  }
}

output "http_response" {
  value = module.ecs_cluster.response
}

output "http_status" {
  value = module.ecs_cluster.status_code
}
