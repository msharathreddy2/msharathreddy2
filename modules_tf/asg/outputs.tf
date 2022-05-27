/****
Output variables
****/
output "launch_template_id" {
  description = "The ID of the launch template"
  value = aws_launch_template.launch_template.id
}

output "launch_template_latest_version" {
  description = "Latest version of the launch template"
  value = aws_launch_template.launch_template.latest_version
}

output "auto_scaling_group_id" {
  description = "The ID of the Auto Scaling Group"
  value = aws_autoscaling_group.asg_group.id
}

output "auto_scaling_group_name" {
  description = "The name of the Auto Scaling Group"
  value = aws_autoscaling_group.asg_group.name
}