provider "aws" {
  region = "ap-southeast-1"
}

# Data resource to fetch EKS cluster details
data "aws_eks_cluster" "cluster" {
  name = module.eks.cluster_name

  depends_on = [module.eks] # Ensure the cluster is created before fetching details
}

data "aws_eks_cluster_auth" "cluster" {
  name = module.eks.cluster_name

  depends_on = [data.aws_eks_cluster.cluster] # Ensure auth token is fetched after cluster info
}

# Kubernetes provider setup
provider "kubernetes" {
  host                   = module.eks.cluster_endpoint
  cluster_ca_certificate = base64decode(module.eks.cluster_certificate_authority_data)
  token                  = data.aws_eks_cluster_auth.cluster.token
}
