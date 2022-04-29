terraform {
  backend "s3" {
    bucket = "rock-infrared-2022-kanba-nm-br-ag"
    key="./tf_files/"
    region = "us-east-1"
  }
}



terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "4.11.0"
    }

    kubernetes = {
      source  = "hashicorp/kubernetes"
      version = "2.11.0"
    }
  }
  required_version = ">= 0.14"
}

# Configure the AWS Provider
provider "aws" {
  region                   = var.region
  shared_credentials_files = ["~/.aws/credentials"]
  profile                  = "966185979698_Admin-Account-Access"
}


provider "kubernetes" {
  host                   = aws_eks_cluster.cluster.endpoint
  token                  = data.aws_eks_cluster_auth.cluster_auth.token
  cluster_ca_certificate = base64decode(aws_eks_cluster.cluster.certificate_authority.0.data)
}
/*
provider "kubernetes" {
  config_path = "~/.kube/config"
}
*/
locals {
  cluster_name = "rock_in"
}




