# Module for creating the SG
module "rdp_mssql_sg" {
  source      = "./modules/security_group"
  name        = "ec2-ftp-mssql-access"
  description = "Allow RDP and MSSQL access"
  vpc_id      = "vpc-0a042b1c409605c9c"
  allowed_cidrs = ["192.50.10.0/24"]
  tags = {
    Environment = "Deve"
    ManagedBy   = "Terraform"
  }
}

# Fetch the EC2 instance by ID
data "aws_instance" "myec2" {
  instance_id = "i-0fc28ab2fb7aff067"  # Replace with your actual instance ID
}

# Attach the SG to the instance's primary network interface
resource "aws_network_interface_sg_attachment" "attach_sg" {
  security_group_id    = module.rdp_mssql_sg.security_group_id
  network_interface_id = "eni-05c647588dee64f24"
}
