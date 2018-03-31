provider "aws" {
  region = "${var.w_aws_region}"
}

resource "aws_instance" "site" {
  instance_type = "t2.micro"

  ami = "${lookup(var.aws_amis, var.w_aws_region)}"
}

resource "aws_elb" "site" {
  name = "w-elb"

  listener {
    instance_port     = 80
    instance_protocol = "http"
    lb_port           = 8080
    lb_protocol       = "http"
  }

  instances = ["${aws_instance.site.id}"]
}
