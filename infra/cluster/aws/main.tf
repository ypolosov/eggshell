terraform {
  required_providers {
    aws = {
      source = "hashicorp/aws"
    }
  }

  cloud {
    organization = "eggshell-organization"

    workspaces {
      name = "eggshell-aws"
    }
  }
}

provider "aws" {
  region = var.region
}
