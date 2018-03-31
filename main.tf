provider "aws" {
  region = "${var.w_aws_region}"
}

resource "aws_instance" "site" {
  instance_type = "t2.micro"

  ami = "${lookup(var.aws_amis, var.w_aws_region)}"

  subnet_id              = "${aws_subnet.sub.id}"
  vpc_security_group_ids = ["${aws_security_group.instances.id}"]

  provisioner "file" {
    source      = "provisioning/nginx.sh"
    destination = "/tmp/setup_nginx.sh"
  }

  provisioner "remote-exec" {
    inline = [
      "chmod +x /tmp/setup_nginx.sh",
      "/tmp/setup_nginx.sh ${aws_instance.site.id}",
    ]
  }
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

  subnets         = ["${aws_subnet.sub.id}"]
  security_groups = ["${aws_security_group.elb.id}"]
}
