variable "aws_region" {
    description = "EC2 Region for the VPC"
    default = "us-west-1"
}

variable "vpc_cidr" {
    description = "CIDR for the whole VPC"
    default = "10.0.0.0/16"
}

variable "public_subnet_cidr" {
    description = "CIDR for the Public Subnet"
    default = "10.0.200.0/24"
}

variable "private_subnet_cidr" {
    description = "CIDR for the Private Subnet"
    default = "10.0.100.0/24"
}


resource "aws_vpc" "demo" {
    cidr_block = "${var.vpc_cidr}"
    enable_dns_hostnames = true
    tags {
        Name = "demo"
    }
}

resource "aws_internet_gateway" "default" {
    vpc_id = "${aws_vpc.demo.id}"
}

resource "aws_route" "internet_access" {
  route_table_id         = "${aws_vpc.demo.main_route_table_id}"
  destination_cidr_block = "0.0.0.0/0"
  gateway_id             = "${aws_internet_gateway.default.id}"
}

resource "aws_subnet" "private" {
  count = "1"
  cidr_block              = "${var.private_subnet_cidr}"
  vpc_id                  = "${aws_vpc.demo.id}"
  map_public_ip_on_launch = true
  availability_zone       = "us-west-1a"

  tags = {
    Name = "private"
  }
}

resource "aws_subnet" "public" {
  count = "1"
  cidr_block              = "${var.public_subnet_cidr}"
  vpc_id                  = "${aws_vpc.demo.id}"
  map_public_ip_on_launch = true
  availability_zone       = "us-west-1a"

  tags = {
    Name = "public"
  }
}
