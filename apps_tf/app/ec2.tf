/**********
ec2_instance
**********/
/*
# service_group: ec2_instance
## service: ec2_instance/ec2_instance
module "ec2_instance_ec2" {
  source = "../../modules_tf/ec2"

  name = "ec2_instance"
  loc  = var.loc

  mod = {
    # meta info
    buildid       = var.loc["buildid"] # str ( timestamp )
    #bootstrap_url = var.bootstrap_url["db"]
    keypair = "Rds-Test-180822"

    # node
    ami          = data.aws_ami.ami.id           # str
    #private_zone = data.aws_route53_zone.pri.id      # str (zone_id)
    #sshkeys      = var.loc_sshkeys["current"]        # str
    #kmskey       = data.aws_kms_key.ebs.arn
    #iam_profile  = aws_iam_instance_profile.ec2-test.id

    # dns
    #private_domain = var.loc_dns["pri"] # str

    
  }
  subnet =  data.aws_subnet.Private.*.id
  

  #node_bootstrap_url = var.bootstrap_url["db"]

  security_groups = [
    data.aws_security_group.Public.id,
    aws_security_group.bastion.id
    #data.aws_security_group.remote_agent.id,
  ]

  spec = var.spec_euronics

  

  #userdata = var.loc_userdata["current"]
}*/