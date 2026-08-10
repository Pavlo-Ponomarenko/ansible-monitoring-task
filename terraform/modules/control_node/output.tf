output "control_node_public_ip" {
  type        = string
  value       = aws_instance.control_node.public_ip
}