module "auto-scaling" {
  source = "../modules/auto-scaling"

  env_code          = var.env_code
  vpc_id            = data.terraform_remote_state.level1.outputs.vpc_id
  private_subnet_id = data.terraform_remote_state.level1.outputs.private_subnet_id
  load_balancer_sg  = module.load-balancer.load_balancer_sg
  target_group_arn  = module.load-balancer.target_group_arn
  ami_id            = data.aws_ami.amazonlinux.id
}
