/********************
EC2 Instance
********************/

# Variables Specific to Instance Creation
/*
# UserData template
data "template_file" "userdata" {
  count    = var.mod["count"]
  #template = file(var.userdata)

  vars = {
    name             = join("-", [var.spec["hosttype"], count.index, var.mod["dc"]])
    #rootkey          = var.mod["sshkeys"]
    domain           = var.mod["private_domain"]

    hosttype         = var.spec["hosttype"]
    environment      = var.loc["grp"]
    manifest_version = var.spec["manifest_version"]
    manifest_type    = var.spec["manifest_type"]
    buildid          = var.spec["buildid"]
    #bootstrapurl     = var.node_bootstrap_url
  }
}

data "template_file" "hostname" {
  count = var.mod["count"]
  #template = "$${hosttype}-$${count}-$${dc}"

  vars = {
    hosttype = var.spec["hosttype"]
    count    = count.index
    dc       = var.mod["dc"]
  }
}
*/
#EC2 Instance
resource "aws_instance" "node" {
  #count                       = var.mod["count"]
  ami                         = var.mod["ami"]
  instance_type               = var.spec["type"]
  vpc_security_group_ids      = var.security_groups
  #iam_instance_profile        = var.mod["iam_profile"]
  associate_public_ip_address = var.spec["public_ip"]
  subnet_id                   = element(var.subnet, 0)
#  user_data                   = element(data.template_file.userdata.*.rendered, count.index)
  key_name                    = var.mod["keypair"]
  monitoring                  = var.spec["monitoring"]
  ebs_optimized               = var.spec["ebs_optimized"]

  root_block_device {
    volume_size           = var.spec["ebs0_size"]
    volume_type           = var.spec["ebs0_type"]
    #iops                  = var.spec["ebs0_iops"] # This Module is not compatible with io1 root block devices
    delete_on_termination = var.spec["ebs0_delete"]
  }

  lifecycle {
    ignore_changes = [volume_tags]
  }

  /*tags = {
    Name        = join("", [var.spec["hosttype"], "-", count.index, "-", var.mod["dc"], ".", var.loc["grp"]])
    CreatedWith = "TF: ${var.loc["path"]} ID: ~/${var.name}.aws_instance.node.${count.index}"
    Expire      = var.loc["expire"]
    # Contact Information
    Owner         = var.loc["owner"]
    Documentation = var.loc["url"]
    # Categorization
    Product     = var.loc["product"]
    Application = var.loc["application"]
    Environment = var.loc["env"]
    Deployment  = var.loc["deploy"]
    Group       = var.loc["group"]
    # Identification
    Domain     = var.mod["private_domain"]
    FQDN       = join("", [var.spec["hosttype"], "-", count.index, "-", var.mod["dc"], ".", var.mod["private_domain"]])
    Hosttype   = var.spec["hosttype"]
    BuildID    = var.spec["buildid"]
    Sitestatus = var.loc["sitestatus"]
  }*/
}
/*
## Internal Route53
resource "aws_route53_record" "node" {
  count      = var.mod["count"]
  depends_on = [aws_instance.node]
  zone_id    = var.mod["private_zone"]
  name       = join("", [var.spec["hosttype"], "-", count.index, "-", var.mod["dc"], ".", var.mod["private_domain"]])
  type       = "A"
  ttl        = var.spec["ttl"]
  records    = [element(aws_instance.node.*.private_ip, count.index)]
}*/