module "vpc" {
  source = "../modules/vpc"

  env_code            = "dev"
  public_subnet_cidr  = ["10.0.0.0/24", "10.0.1.0/24", "10.0.2.0/24"]
  private_subnet_cidr = ["10.0.100.0/24", "10.0.101.0/24", "10.0.103.0/24"]
  vpc_cidr            = "10.0.0.0/16"
}
