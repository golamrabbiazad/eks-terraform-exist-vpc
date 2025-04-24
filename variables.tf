locals {
  name   = "mongo-express-eks"
  region = "<replace_with_your_region_exsting_vpc_eg_us-east-2>"

  eks_cluster_version = "1.32"
  authentication_mode = "API"
  ip_family           = "ipv4"

  cluster_creator_admin_permissions = true

  tags = {
    Example = local.name
  }

  vpc_id           = "<replace_with_your_existing_vpc>"
  private_a_subnet = "<replace_with_your_existing_vpc_subnet_1a>"
  private_b_subnet = "<replace_with_your_existing_vpc_subnet_1b>"
  private_c_subnet = "<replace_with_your_existing_vpc_subnet_1c>"

  private_subnet_ids = [
    data.aws_subnet.private_a.id,
    data.aws_subnet.private_b.id,
    data.aws_subnet.private_c.id,
  ]

  endpoint_public_access  = true
  public_access_cidrs     = ["0.0.0.0/0"]
  endpoint_private_access = true

  mongodb_config_server         = "<private_ipv4_addr_mongod_vm_server_existing_vpc>"
  mongodb_config_port           = "27017"
  mongodb_config_admin_username = "admin"
  mongodb_config_admin_password = "6181Mongodb!"
  mongodb_config_auth_db        = "admin"


  wiz_node_app_name         = "wiz-node-app"
  wiz_node_app_docker_image = "<docker_image_name_in_docker_hub_or_aws_ecr>"
}
