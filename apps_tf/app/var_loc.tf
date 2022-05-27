/****
Local Variables
****/

variable "loc" {
  default = {
    name    = "var_loc"  # May or may not be same as deployment
    account = "863662138515"
    region  = "ap-south-1"
    role    = ""    # IAM Role used  to deploy AWS Resources
    ami     = "ami-041db4a969fe3eb68"
    buildid = "testbuild"
    keypair = "test"

    # Categorization
    product     = "amara"
    application = "amara-ec2"
    environment = "test"
    deployment  = "test-infra"
    group       =  "test server"
    sitestatus  =  "active"

    # Short Categorization
    prod   = "amara"
    app    = "apps-ser"
    env    = "test"
    deploy = "test-infra"
    grp    =  "apps-srvr"

    # Categorization Hierarchy.
    path = "/tf-aws/app-tf/app" 
    id   = "ec2" 

    # Meta Info
    expire = ""                              
    url    = "" 
    sme    = "user1"    
    owner  = ""                        
  }
}

variable "loc_azs" {
  default = ["a", "b", "c"]
}

variable "nat_loc_azs" {
  default = ["a", "b"]
}

variable "loc_dns" {
  default = {
    pub = ""       
    pri = ""
  }
}

variable "loc_peer" {
  default = {}
}

variable "loc_tags" {
  default = {
    creator   = ""
    requester = ""
  }
}
