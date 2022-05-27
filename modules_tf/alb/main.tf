/********
Module: alb
********/

resource "aws_alb" "alb" {
  name                       = join("-",[var.spec["albname"],var.loc["grp"]])
  internal                   = var.spec["internal"]
  security_groups            = var.security_groups
  subnets                    = var.subnets
  enable_deletion_protection = false
  idle_timeout               = var.spec["idle_timeout"]

  /*access_logs {
    enabled = var.spec["logging"]
    bucket  = var.loc["log_bucket"]
    prefix  = join("/",["logs",var.loc["grp"],var.spec["albname"]])
  }*/

  tags = {
    Name        = join("",["ALB:",var.spec["albname"],"-",var.loc["grp"]])
    CreatedWith = join("",["TF: ",var.loc["path"]," ID: module.",var.mod["name"],".aws_alb.alb"])
    Product     = var.loc["product"]
    Application = var.loc["application"]
    Environment = var.loc["environment"]
    Deployment  = var.loc["deployment"]
    Expire      = var.loc["expire"]
  }
}

resource "aws_alb_listener" "alb_http" {
  count             = var.spec["enable_http"] ? 1 : 0
  load_balancer_arn = aws_alb.alb.arn
  port              = "80"
  protocol          = "HTTP"
  
  default_action {
    target_group_arn = aws_alb_target_group.alb.arn
    type             = "forward"
  }
}
/*
resource "aws_alb_listener" "alb_https" {
  count             = var.spec["enable_https"] ? 1 : 0
  load_balancer_arn = aws_alb.alb.arn
  port              = "443"
  protocol          = "HTTPS"
  ssl_policy        = "ELBSecurityPolicy"
  #certificate_arn   = var.mod["cert"]
  default_action {
    target_group_arn = aws_alb_target_group.alb.arn
    type             = "forward"
  }
}
*/
resource "aws_alb_target_group" "alb" {
  name                 = join("-",["alb",var.spec["albname"],var.loc["grp"]])
  port                 = var.spec["port"]
  protocol             = "HTTP"
  vpc_id               = var.mod["vpc_id"]
  deregistration_delay = var.spec["deregistration_delay"]

  health_check {
    interval            = var.spec["interval"]
    path                = var.spec["path"]
    port                = var.spec["health_port"]
    protocol            = var.spec["health_protocol"]
    timeout             = var.spec["timeout"]
    healthy_threshold   = var.spec["healthy_threshold"]
    unhealthy_threshold = var.spec["unhealthy_threshold"]
    matcher             = var.spec["matcher"]
  }

  stickiness {
    type            = "lb_cookie"
    cookie_duration = var.spec["stickiness"]
    enabled         = var.spec["sticky"]
  }

  tags = {
    Name        = join("-",["alb",var.spec["albname"],var.loc["grp"]])
    CreatedWith = join("",["TF: ",var.loc["path"], " ID: module.",var.mod["name"],".aws_alb_target_group.alb"])
    Product     = var.loc["product"]
    Application = var.loc["application"]
    Environment = var.loc["environment"]
    Deployment  = var.loc["deployment"]
    Expire      = var.loc["expire"]
  }
}

resource "aws_alb_target_group_attachment" "alb" {
  count            = var.spec["nodes"]
  target_group_arn = aws_alb_target_group.alb.arn
  target_id        = element(var.node_ids, count.index)
  port             = var.spec["port"]
}