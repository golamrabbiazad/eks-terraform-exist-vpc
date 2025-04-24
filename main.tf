data "aws_availability_zones" "available" {
  # Exclude local zones
  filter {
    name   = "opt-in-status"
    values = ["opt-in-not-required"]
  }
}

data "aws_vpc" "existing" {
  id = local.vpc_id
}

data "aws_subnet" "private_a" {
  id = local.private_a_subnet
}

data "aws_subnet" "private_b" {
  id = local.private_b_subnet
}

data "aws_subnet" "private_c" {
  id = local.private_c_subnet
}
