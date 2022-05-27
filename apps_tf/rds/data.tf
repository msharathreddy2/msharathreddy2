# VPC
data "aws_vpc" "default" {
  filter {
    name = "tag:Name"

    values= ["vpc-or-prod-tf-vpc"]
  }
}

# SUBNETS
data "aws_subnet" "data" {
  count = length(var.loc_azs)

  filter {
    name   = "vpc-id"
    values = [data.aws_vpc.default.id]
  }

  filter {
    name   = "tag:Name"
    values = ["SN: Data Z${count.index}*"]
  }
}
