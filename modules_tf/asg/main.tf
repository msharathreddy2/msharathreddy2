/***
Launch Template for ASG. Contains the ASG nodes configuration
***/
resource "aws_launch_template" "launch_template" {  
    name            = join("-",["lt", var.spec["hosttype"]])
    image_id        = var.mod["ami"]
    instance_type   = var.spec["type"]

    iam_instance_profile {
        name = var.mod["iam_profile"]
    }
    
    key_name    = var.loc["keypair"]

    vpc_security_group_ids  = var.security_groups

    # Required to redeploy without an outage.
    lifecycle {
        create_before_destroy = true
    }

    block_device_mappings {
            device_name = "/dev/sda1"
            ebs  {
                volume_size           = var.spec["ebs0_size"]
                volume_type           = var.spec["ebs0_type"]
                iops                  = var.spec["ebs0_iops"]
                delete_on_termination = var.spec["ebs0_delete"]
            }
    }
    block_device_mappings {
            device_name = var.spec["ebs1_device"]
            ebs {
                volume_size           = var.spec["ebs1_size"]
                volume_type           = var.spec["ebs1_type"]
                iops                  = var.spec["ebs1_iops"]
                delete_on_termination = var.spec["ebs1_delete"]
                encrypted             = true
            }
    }

    
}


/***
Auto Scaling Group
***/
resource "aws_autoscaling_group" "asg_group" {
    name                = join("-", ["asg", var.spec["hosttype"]])
    min_size            = var.spec["cnt_min"]
    max_size            = var.spec["cnt_max"]

    health_check_type           = "ELB"
    health_check_grace_period   = var.health_check_grace_period
    target_group_arns           = var.target_group_arn
    suspended_processes         = var.suspended_processes
    launch_template {
          id        = aws_launch_template.launch_template.id
          version   = aws_launch_template.launch_template.latest_version
    }

    enabled_metrics = [
            "GroupMinSize",
            "GroupMaxSize",
            "GroupDesiredCapacity",
            "GroupInServiceInstances",
            "GroupTotalInstances"
    ]
    metrics_granularity ="1Minute"

    vpc_zone_identifier  = var.subnet

    # Required to redeploy without an outage.
    lifecycle {
            create_before_destroy = true
    }

    termination_policies = ["OldestInstance", "OldestLaunchTemplate"]

    tag {
            key                 = "Application"
            value               = var.loc["application"]
            propagate_at_launch = true
    }

    tag {
            key                 = "BuildID"
            value               = var.mod["buildid"]
            propagate_at_launch = true
    }

    tag {
            key                 = "CreatedWith"
            value               = join(":",["TF",var.loc["path"]])
            propagate_at_launch = true
    }

    tag {
            key                 = "Deployment"
            value               = var.loc["deploy"]
            propagate_at_launch = true
    }

    tag {
            key                 = "Documentation"
            value               = var.loc["url"]
            propagate_at_launch = true
    }

   /* tag {
            key                 = "Domain"
            value               = var.loc["dns"]
            propagate_at_launch = true
    }*/

    tag {
            key                 = "Environment"
            value               = var.loc["env"]
            propagate_at_launch = true
    }

    tag {
            key                 = "Expires"
            value               = var.loc["expire"]
            propagate_at_launch = true
    }

    tag {
            key                 = "Hosttype"
            value               = var.spec["hosttype"]
            propagate_at_launch = true
    }

    tag {
            key                 = "Group"
            value               = var.loc["group"]
            propagate_at_launch = true
    }

    tag {
            key                 = "Name"
            value               = join(".",[var.spec["hosttype"],var.loc["grp"]])
            propagate_at_launch = true
    }

    tag {
            key                 = "Owner"
            value               = var.loc["owner"]
            propagate_at_launch = true
    }

    tag {
            key                 = "Product"
            value               = var.loc["product"]
            propagate_at_launch = true
    }

    tag {
            key                 = "Sitestatus"
            value               = var.loc["sitestatus"]
            propagate_at_launch = true
    }
}

