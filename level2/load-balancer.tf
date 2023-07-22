module "load-balancer" {
  source = "../modules/load-balancer"

  env_code         = var.env_code
  vpc_id           = data.terraform_remote_state.level1.outputs.vpc_id
  public_subnet_id = data.terraform_remote_state.level1.outputs.public_subnet_id
}
