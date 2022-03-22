# output "ec2_id" {
#   description = "The ID of the EC2"
#   value       = concat(aws_instance.fiap-hmv.*.id, [""])[0]
# }

# output "ec2_arn" {
#   description = "The ARN of the EC2"
#   value       = concat(aws_instance.fiap-hmv.*.arn, [""])[0]
# }

# output "public_ip" {
#   value       = aws_instance.fiap-hmv.public_ip
#   description = "The public IP of the web server"
# }

output "elb_dns_name" {
  value       = aws_elb.fiap-hmv.dns_name
  description = "The domain name of the load balancer"
}