# Module for creating the SG
module "rdp_mssql_sg" {
  source      = "./modules/security_group"
  name        = "rdp-mssql-access"
  description = "Allow RDP and MSSQL access"
  vpc_id      = "vpc-xxxxxxxx"
  allowed_cidrs = ["192.168.1.0/24"]
  tags = {
    Environment = "Dev"
    ManagedBy   = "Terraform"
  }
}

# Fetch the EC2 instance by ID
data "aws_instance" "target" {
  instance_id = "i-0abcdef1234567890"  # Replace with your actual instance ID
}

# Attach the SG to the instance's primary network interface
resource "aws_network_interface_sg_attachment" "attach_sg" {
  security_group_id    = module.rdp_mssql_sg.security_group_id
  network_interface_id = data.aws_instance.target.primary_network_interface_id
}
