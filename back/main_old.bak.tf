# Module for creating the SG
module "rdp_mssql_sg" {
  source      = "./modules/security_group"
  name        = "rdp-mssql-access"
  description = "Allow RDP and MSSQL access"
  vpc_id      = "vpc-0a042b1c409605c9c"
  allowed_cidrs = ["192.168.1.0/24"]
  tags = {
    Environment = "Dev"
    ManagedBy   = "Terraform"
  }
}

# Fetch the EC2 instance by ID
data "aws_instance" "target1" {
  instance_id = "i-0c4058e53e9938e97"  # Replace with your actual instance ID
}

# Attach the SG to the instance's primary network interface
resource "aws_network_interface_sg_attachment" "attach_sg" {
  security_group_id    = module.rdp_mssql_sg.security_group_id
  network_interface_id = "eni-05c647588dee64f24"
}
