terraform {
  
  backend "s3" {
    bucket   = "ext0001"
    key    =   "aws-tf/awstf.state" 
    region   = "ap-south-1"
    profile  = "default"
    #role_arn = "arn:aws:iam::376886296507:role/OpsAdmin_role"
  }
}