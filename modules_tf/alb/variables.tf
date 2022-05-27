/****
Module: alb
****/

variable "mod" {
  type = map(string)
  default = {
    name   = "" # STR: Name of module
    vpc_id = "" # STR: usually "${data.aws_vpc.default.id}"
    cert   = "" # STR: usually "${data.aws_acm_certificate.default.arn}"
  }
}

variable "loc" {
  type = map(string)
}

variable "spec" {
  type = map(string)
}

variable "security_groups" {
  type = list(string)
}

variable "subnets" {
  type = list(string)
}

variable "node_ids" {
  type = list(string)
}