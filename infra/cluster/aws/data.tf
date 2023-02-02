data "aws_ami" "last_ubuntu" {
  most_recent = true             # только новейшая версия
  owners      = ["099720109477"] # id владельца образа

  filter {
    name   = "name"                                                     # название фильтра - по какому параметру искать
    values = ["ubuntu/images/hvm-ssd/ubuntu-jammy-22.04-amd64-server*"] # что искать
  }
}

# data "aws_subnet" "default_a" {
#   filter {
#     name   = "availability-zone"
#     values = ["eu-west-3a"]
#   }
# }

# data "aws_vpc" "default" {
#   default = true
# }

# data "aws_security_group" "default" {
#   name = "default"
# }
# data "aws_internet_gateway" "default" {
#   filter {
#     name   = "attachment.vpc-id"
#     values = [data.aws_vpc.default.id]
#   }
# }

# data "aws_route_table" "default" {
#   vpc_id = data.aws_vpc.default.id
# }
