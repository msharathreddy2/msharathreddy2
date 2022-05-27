resource "aws_security_group" "bastion" {
  name        = join("-", ["bastion", var.loc["id"]])
  description = "bastion Access"
  vpc_id      = data.aws_vpc.default.id

  tags = {
    Name        = join("-", ["sg-bastion", var.loc["id"]])
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

resource "aws_security_group_rule" "bastion_ingress" {
  type        = "ingress"
  from_port   = 0
  to_port     = 0
  protocol    = "-1"
  cidr_blocks       = ["10.0.101.0/24", "10.0.102.0/24", "10.0.103.0/24"]
  security_group_id = aws_security_group.bastion.id
}