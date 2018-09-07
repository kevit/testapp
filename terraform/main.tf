data "aws_vpc" "demo" {
  default = true
}

resource "aws_eip" "this" {
  vpc      = true
  instance = "${module.ec2.id[0]}"
}

data "aws_subnet_ids" "all" {
  vpc_id = "${data.aws_vpc.demo.id}"
}

module "security_group" {
  source = "terraform-aws-modules/security-group/aws"

  name        = "demo"
  description = "Security group for example usage with EC2 instance"
  vpc_id      = "${data.aws_vpc.demo.id}"

  ingress_cidr_blocks = ["0.0.0.0/0"]
#https://github.com/terraform-aws-modules/terraform-aws-security-group/blob/master/modules/README.md
  ingress_rules       = ["ssh-tcp", "http-80-tcp", "all-icmp"]
  egress_rules        = ["all-all"]
}

module "ec2" {
  source = "terraform-aws-modules/ec2-instance/aws"

  name                        = "demo"
  ami                         = "ami-5c66ea23"
  instance_type               = "t2.mini"
  key_name               = "demo"
  subnet_id                   = "${element(data.aws_subnet_ids.all.ids, 0)}"
  vpc_security_group_ids      = ["${module.security_group.this_security_group_id}"]
  associate_public_ip_address = true
}
