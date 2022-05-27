/****
Input Variables used for node ASG module
****/

variable "name"            { type = string }
variable "loc"             { type = map(string) }
variable "mod"             {
  type = map(string)
  default = {
    buildid        = "null"
    ami            = ""
    iam_profile    = ""
    #private_domain = ""
    #private_zone   = ""
    #sshkeys        = ""
    #kmskey         = ""
    #bootstrap_url  = ""
     

  }
}
variable "security_groups" { type = list(string) }
variable "spec"            { type = map(string) }
variable "subnet"          { type = list(string) }
variable "target_group_arn"		   { type = list(string) }

variable "health_check_grace_period" { type = string }

variable "suspended_processes" {
  type = list(string)
}

variable "node_bootstrap_url" {
  type = string
  default = ""
}