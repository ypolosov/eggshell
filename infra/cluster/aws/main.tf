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


resource "aws_key_pair" "test_key" {
  key_name   = "test-key"
  public_key = var.ssh_public_key
}

resource "aws_vpc" "test-env" {
  cidr_block           = "10.0.0.0/16"
  enable_dns_hostnames = true
  enable_dns_support   = true
  tags = {
    Name = "test-env"
  }
}

resource "aws_subnet" "default_a" {
  cidr_block        = cidrsubnet(aws_vpc.test-env.cidr_block, 3, 1)
  vpc_id            = aws_vpc.test-env.id
  availability_zone = "eu-west-3a"
}

resource "aws_security_group" "ingress-all-test" {
  name   = "allow-all-sg"
  vpc_id = aws_vpc.test-env.id
  ingress {
    cidr_blocks = [
      "0.0.0.0/0"
    ]
    from_port = 22
    to_port   = 22
    protocol  = "tcp"
  }
  // Terraform removes the default rule
  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

resource "aws_instance" "default" {
  ami           = data.aws_ami.last_ubuntu.id # ОС (Ubuntu, 22.04 LTS)
  instance_type = "t3.micro"                  # тип процессора и ресурс машины (CPU и RAM)
  # subnet_id                   = data.aws_subnet.default_a.id # одна из дефолтных подсетей
  associate_public_ip_address = true # автоматически установить динамический ip
  tags = {
    Name = "test-instance"
  }
  key_name        = aws_key_pair.test_key.key_name
  security_groups = ["${aws_security_group.ingress-all-test.id}"]
  subnet_id       = aws_subnet.default_a.id
}


resource "aws_eip" "ip-test-env" {
  instance = aws_instance.default.id
  vpc      = true
}

resource "aws_internet_gateway" "test-env-gw" {
  vpc_id = aws_vpc.test-env.id
  tags = {
    Name = "test-env-gw"
  }
}

resource "aws_route_table" "route-table-test-env" {
  vpc_id = aws_vpc.test-env.id
  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.test-env-gw.id
  }
  tags = {
    Name = "test-env-route-table"
  }
}
resource "yandex_vpc_subnet" "subnet-association" {
  subnet_id      = aws_subnet.default_a.id
  route_table_id = aws_route_table.route-table-test-env.id
}
