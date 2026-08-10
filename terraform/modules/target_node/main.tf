resource "aws_security_group" "target_vm_sg" {
  name        = "target-vm-sg"
  description = "Allow SSH and Port 9100 traffic strictly from Control Node"
  vpc_id      = aws_vpc.main.id

  ingress {
    description     = "SSH from Control Node"
    from_port       = 22
    to_port         = 22
    protocol        = "tcp"
    security_groups = [aws_security_group.control_node_sg.id]
  }

  ingress {
    description     = "Prometheus Node Exporter / Port 9100 from Control Node"
    from_port       = 9100
    to_port         = 9100
    protocol        = "tcp"
    security_groups = [aws_security_group.control_node_sg.id]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "target-vm-sg"
  }
}

# Dynamic lookup for latest Ubuntu 22.04 LTS AMI
data "aws_ami" "ubuntu" {
  most_recent = true
  owners      = ["099720109477"] # Canonical

  filter {
    name   = "name"
    values = ["ubuntu/images/hvm-ssd/ubuntu-jammy-22.04-amd64-server-*"]
  }

  filter {
    name   = "virtualization-type"
    values = ["hvm"]
  }
}

# 3 Target VMs (t3.micro) in Private Subnet
resource "aws_instance" "target_vms" {
  count                  = 3
  ami                    = data.aws_ami.ubuntu.id
  instance_type          = "t3.micro"
  subnet_id              = var.private_subnet_id
  vpc_security_group_ids = [aws_security_group.target_vm_sg.id]
  key_name               = var.key_name

  tags = {
    Name = "target-${count.index + 1}"
  }
}