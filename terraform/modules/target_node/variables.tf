variable "vpc_id" {
  type = string
}

variable "private_subnet_id" {
  type = string
}

variable "control_node_sg_id" {
  type = string
}

variable "key_name" {
  type        = string
  default     = "devops-lab"
}