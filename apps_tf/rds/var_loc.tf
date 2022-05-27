/****
Local Variables
****/

variable "loc" {
  default = {
    name    = "var_loc"  # May or may not be same as deployment
    account = "863662138515"
    region  = "ap-south-1"
    role    = ""    # IAM Role used  to deploy AWS Resources

    # Categorization
    product     = "amara"
    application = "amara-db"
    environment = "test"
    deployment  = "test-infra"

    # Short Categorization
    prod   = "amara"
    app    = "apps-db"
    env    = "test"
    deploy = "test-infra"
    group  = "rds"

    # Categorization Hierarchy.
    path = "/tf-aws/app_tf/rds" 
    id   = "tf-rds" 

    # Meta Info
    expire = "2021-12-31"                              
    url    = "" 
    sme    = "user1"    
    owner  = "user1"                        
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
