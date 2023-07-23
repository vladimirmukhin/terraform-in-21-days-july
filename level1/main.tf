data "aws_availability_zones" "available" {
  state = "available"
}

module "vpc" {
  source  = "terraform-aws-modules/vpc/aws"
  version = "3.14.2"

  name               = var.env_code
  cidr               = var.vpc_cidr
  azs                = data.aws_availability_zones.available.names[*]
  private_subnets    = var.private_subnet_cidr
  public_subnets     = var.public_subnet_cidr
  enable_nat_gateway = true
}
