# need to get vpc id from logged in aws account

# get account from get-caller-identity
data "aws_caller_identity" "current" {}

# get vpc id from account from us-east-1 region
data "aws_vpc" "default" {
  default = true
  provider = aws
}

# get all subnets from vpc id
data "aws_subnets" "all" {
  filter {
        name = "vpc-id"
        values = [data.aws_vpc.default.id]
    }
  filter {
    name = "availability-zone"
     values = ["${var.region}a", "${var.region}b", "${var.region}c", "${var.region}d", "${var.region}f"]
  }
}

# output "vpc_id" {
#   value = data.aws_subnets.all.ids
# }