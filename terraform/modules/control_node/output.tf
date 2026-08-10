output "control_node_public_ip" {
  type        = string
  value       = aws_instance.control_node.public_ip
}

output "control_node_sg_id" {
  type        = string
  value       = aws_security_group.control_node_sg.id
}