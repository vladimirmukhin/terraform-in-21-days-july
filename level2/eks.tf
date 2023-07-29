module "eks" {
  source  = "terraform-aws-modules/eks/aws"
  version = "19.15.3"

  cluster_name    = "${var.env_code}-cluster"
  cluster_version = "1.27"

  vpc_id                         = data.terraform_remote_state.level1.outputs.vpc_id
  subnet_ids                     = data.terraform_remote_state.level1.outputs.private_subnet_id
  cluster_endpoint_public_access = true

  eks_managed_node_group_defaults = {
    ami_type = "AL2_x86_64"

  }

  eks_managed_node_groups = {
    one = {
      name = "node-group-1"

      instance_types = ["t3.small"]

      min_size     = 3
      max_size     = 3
      desired_size = 3
    }
  }
}
