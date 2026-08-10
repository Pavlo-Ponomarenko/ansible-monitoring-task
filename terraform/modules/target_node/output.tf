output "target_vm_private_ips" {
  type        = list(string)
  value       = aws_instance.target_vms[*].private_ip
}