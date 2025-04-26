variable "name" {
  description = "Name of the security group"
  type        = string
}

variable "description" {
  description = "Security group description"
  type        = string
}

variable "vpc_id" {
  description = "VPC ID where the SG will be created"
  type        = string
}

variable "allowed_cidrs" {
  description = "List of CIDR blocks allowed for ingress"
  type        = list(string)
  default     = ["0.0.0.0/0"]
}

variable "tags" {
  description = "Tags to apply"
  type        = map(string)
  default     = {}
}
