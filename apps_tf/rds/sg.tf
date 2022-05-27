 resource "aws_security_group" "data" {
  name        = join("-", ["data", var.loc["id"]])
  description = "Private Subnet Access for database"
  vpc_id      = data.aws_vpc.default.id

  tags = {
    Name        = join("-", ["sg-data", var.loc["id"]])
    Expire      = var.loc["expire"]
    # Contact Information

    Owner         = var.loc["owner"]
    SME           = var.loc["sme"]
    Documentation = var.loc["url"]
    # Categorization
    Product     = var.loc["product"]
    Application = var.loc["application"]
    Environment = var.loc["env"]
    Deployment  = var.loc["deploy"]
  }
}

resource "aws_security_group_rule" "data_ingress" {
  #count = length(keys(var.private_subnets))
  type        = "ingress"
  from_port   = 1433
  to_port     = 1433
  protocol    = "-1"
  cidr_blocks       = ["10.0.1.0/24", "10.0.2.0/24", "10.0.3.0/24"]
  security_group_id = aws_security_group.data.id
}