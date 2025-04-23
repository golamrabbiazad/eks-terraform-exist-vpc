module "eks" {
  source  = "terraform-aws-modules/eks/aws"
  version = "~> 20.0"

  cluster_name    = "${local.name}-tf"
  cluster_version = local.eks_cluster_version

  authentication_mode = local.authentication_mode
  cluster_ip_family   = local.ip_family

  enable_cluster_creator_admin_permissions = local.cluster_creator_admin_permissions

  cluster_endpoint_private_access      = local.endpoint_private_access
  cluster_endpoint_public_access       = local.endpoint_public_access
  cluster_endpoint_public_access_cidrs = local.public_access_cidrs

  # EKS Addons
  cluster_addons = {
    coredns                = {}
    eks-pod-identity-agent = {}
    kube-proxy             = {}
    vpc-cni                = {}
  }

  vpc_id     = data.aws_vpc.existing.id
  subnet_ids = local.private_subnet_ids

  eks_managed_node_groups = {
    mongo-express-node = {
      instance_types = ["t3.medium"]
      ami_type       = "AL2023_x86_64_STANDARD"

      min_size     = 2
      max_size     = 2
      desired_size = 2

      cloudinit_pre_nodeadm = [
        {
          content_type = "application/node.eks.aws"
          content      = <<-EOT
            ---
            apiVersion: node.eks.aws/v1alpha1
            kind: NodeConfig
            spec:
              kubelet:
                config:
                  shutdownGracePeriod: 30s
                  featureGates:
                    DisableKubeletCloudCredentialProviders: true
          EOT
        }
      ]
    }
  }

  tags = local.tags
}
