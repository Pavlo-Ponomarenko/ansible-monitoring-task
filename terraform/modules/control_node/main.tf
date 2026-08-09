resource "aws_security_group" "control_node_sg" {
  name        = "control-node-sg"
  description = "Allow SSH ingress to Control Node and all egress"
  vpc_id      = aws_vpc.main.id

  ingress {
    description = "SSH from anywhere"
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"] # Restrict to your specific IP range in production
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    ="-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "control-node-sg"
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

# Control Node (t3.small) in Public Subnet
resource "aws_instance" "control_node" {
  ami                         = data.aws_ami.ubuntu.id
  instance_type               = "t3.small"
  subnet_id                   = aws_subnet.public.id
  vpc_security_group_ids      = [aws_security_group.control_node_sg.id]
  key_name                    = aws_key_pair.generated_key.key_name
  associate_public_ip_address = true

  tags = {
    Name = "Control-Node"
  }
}