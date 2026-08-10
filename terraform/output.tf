output "control_node_public_ip" {
  type        = string
  description = "Public IP address of the control node"
  value       = module.control_node.control_node_public_ip
}

output "target_vms_private_ips" {
  type        = list(string)
  description = "List of private IP addresses for target instances"
  value       = module.target_node.target_vm_private_ips
}