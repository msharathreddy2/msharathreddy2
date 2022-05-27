data "aws_ami" "ami" {
#most_recent = true #executable_users = ["self"]

filter {
name = "name"
values = ["${var.loc["ami"]}"]
}

owners = ["${var.loc["account"]}"]
} 
# VPC
data "aws_vpc" "default" {
  filter {
    name = "tag:Name"

    values= ["vpc-or-prod-tf-vpc"]
  }
}

# SUBNETS
data "aws_subnet" "Private" {
  count = length(var.loc_azs)

  filter {
    name   = "vpc-id"
    values = [data.aws_vpc.default.id]
  }

  filter {
    name   = "tag:Name"
    values = ["SN: Private Z${count.index}*"]
  }
}

data "aws_subnet" "Public" {
  count = length(var.loc_azs)

  filter {
    name   = "vpc-id"
    values = [data.aws_vpc.default.id]
  }

  filter {
    name   = "tag:Name"
    values = ["SN: Public Z${count.index}*"]
  }
}

# Security Groups
data "aws_security_group" "Public" {
filter {
name = "vpc-id"
values = [data.aws_vpc.default.id]
}

filter {
name = "tag:Name"
values = ["sg-public-https-tf-vpc"]
}
} 

data "aws_security_group" "Private" {
filter {
name = "vpc-id"
values = [data.aws_vpc.default.id]
}

filter {
name = "tag:Name"
values = ["sg-bastion-ec2"]
}
} 
