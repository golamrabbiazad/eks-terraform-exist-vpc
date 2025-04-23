locals {
  name   = "mongo-express-eks"
  region = "ap-southeast-1"

  eks_cluster_version = "1.31"
  authentication_mode = "API"
  ip_family           = "ipv4"

  cluster_creator_admin_permissions = true

  tags = {
    Example = local.name
  }


  vpc_id = "<replace_with_your_existing_vpc>"

  private_subnet_ids = [
    data.aws_subnet.private_a.id,
    data.aws_subnet.private_b.id,
    data.aws_subnet.private_c.id,
  ]

  endpoint_public_access  = true
  public_access_cidrs     = ["0.0.0.0/0"]
  endpoint_private_access = true
}
