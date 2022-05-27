/**********
Outputs
**********/

/*output "nodename" {
  value = [ data.template_file.hostname.*.rendered ]
}*/

output "ids" {
  value = aws_instance.node.*.id
}

/*output "fqdns" {
  value = aws_route53_record.node.*.fqdn
}
*/
output "private_ips" {
  value = aws_instance.node.*.private_ip
}

output "public_ips" {
  value = aws_instance.node.*.public_ip
}