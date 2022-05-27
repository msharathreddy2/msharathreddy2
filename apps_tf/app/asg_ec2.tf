module "ec2_asg" {
  source = "../../modules_tf/asg" #fix this 

  name = "amara"
  loc  = var.loc

  mod = {
    # meta info
    buildid = var.loc["buildid"] # str ( timestamp )
    # node
    ami          = data.aws_ami.ami.id # str 
    iam_profile  = aws_iam_instance_profile.ec2_profile.name 
    #private_zone = data.aws_route53_zone.pri.id # str (zone_id)
    #sshkeys      = var.sshkeys["root"]
    kmskey       = ""
    # dns
    #private_domain = var.loc_dns["pri"] # str
    #ootstrap_url  = var.bootstrap_url["compute"]
  }

  health_check_grace_period = 240
  suspended_processes       = []
  #node_bootstrap_url        = var.bootstrap_url["compute"]

  security_groups = [
    data.aws_security_group.Private.id
  ]

  spec = var.spec_asg

  subnet = data.aws_subnet.Private.*.id 


  #userdata = var.loc["userdata"]

  target_group_arn = [module.euronics_alb.target_groups]
}

# amara ALB
module "amara_alb" {
  source = "../../modules_tf/alb"

  mod = {
    name   = "amara_alb"
    vpc_id = data.aws_vpc.default.id
    #cert   = data.aws_acm_certificate.default.arn
  }

  node_ids = []
  loc    = var.loc
  spec     = var.speclb_amara
  subnets = split(
    ",",
    var.speclb_amara["internal"] ? join(",", data.aws_subnet.Private.*.id) : join(",", data.aws_subnet.Public.*.id),
  )

  security_groups = [
    data.aws_security_group.Public.id,
  ]
}