data "aws_eks_cluster" "default" {
  name = "${var.env_code}-cluster"
}

data "aws_eks_cluster_auth" "default" {
  name = "${var.env_code}-cluster"
}

provider "kubernetes" {
  host                   = data.aws_eks_cluster.default.endpoint
  cluster_ca_certificate = base64decode(data.aws_eks_cluster.default.certificate_authority[0].data)
  token                  = data.aws_eks_cluster_auth.default.token
}

provider "helm" {
  kubernetes {
    host                   = data.aws_eks_cluster.default.endpoint
    cluster_ca_certificate = base64decode(data.aws_eks_cluster.default.certificate_authority[0].data)
    token                  = data.aws_eks_cluster_auth.default.token
  }
}

resource "helm_release" "game-2048" {
  name  = "game-2048"
  chart = "./helm/webapp"

  set {
    name  = "image"
    value = "alexwhen/docker-2048"
  }
}
