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

resource "aws_instance" "default" {
  ami                         = "ami-0afd55c0c8a52973a"    # ОС (Ubuntu, 22.04 LTS)
  instance_type               = "t3.micro"                 # тип процессора и ресурс машины (CPU и RAM)
  subnet_id                   = "subnet-083e6806ee6be3c7e" # одна из дефолтных подсетей
  associate_public_ip_address = true                       # автоматически установить динамический ip
  tags = {
    Name = "test-instance"
  }
}
