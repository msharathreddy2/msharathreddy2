/*********
Module Inputs
*********/

variable "loc"             { type = map(string) }
variable "name"            { type = string }
variable "mod"             { 
  type = map(string)
  default = {
    # meta info
    az             = "" # str ( ${region}${az.index} )
    buildid        = "" # str ( timestamp )
    dc             = "" # str ( ${dccode}${az.index} )
    hosttype       = "" # str
    name           = "" # str (Name of calling module)
    bootstrap_url  = "" # str
    # node
    ami            = "" # str
    count          = "" # num
    ebs_optimized  = "" # boolean
    kmskey         = ""
    instance_type  = "" # str
    iam_profile    = ""
    keypair        = "" # str 
    montoring      = true # boolean
    private_zone   = "" # str (zone_id)
    public_ip      = false # boolean
    sshkeys        = "" # str
    subnet         = "" # str
    # dns
    private_domain = "" # str
    ttl            = "" # num
  }
}
variable "security_groups" { type = list(string) }
variable "spec"            {
  type = map(string)
  default = {
    manifest_version = "v0_0_1"
    manifest_type    = "default"
  }
}
#variable "userdata"        { type = string }

#variable "node_bootstrap_url" {
 # type = string
  #default = ""
#}





variable "subnet" {
 type =list(string) 
}