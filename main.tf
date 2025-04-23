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
  id = "<subnet_a>"
}

data "aws_subnet" "private_b" {
  id = "<subnet_b>"
}

data "aws_subnet" "private_c" {
  id = "<subnet_c>"
}


