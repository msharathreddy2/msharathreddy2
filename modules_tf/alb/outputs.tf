/****
ALB Out files
****/

output "dns_name" {
  value = aws_alb.alb.dns_name
}

output "zone_id" {
  value = aws_alb.alb.zone_id
}

output "target_groups" {
  value = aws_alb_target_group.alb.arn
}
/*
output  "listener_https" {
  value = (aws_alb_listener.alb_https.*.arn)
}*/