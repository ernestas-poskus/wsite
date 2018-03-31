resource "aws_vpc" "site" {
  cidr_block           = "10.0.0.0/16"
  enable_dns_hostnames = true
}

resource "aws_subnet" "sub" {
  vpc_id                  = "${aws_vpc.site.id}"
  cidr_block              = "10.0.0.0/24"
  map_public_ip_on_launch = true
}

resource "aws_internet_gateway" "gateway" {
  vpc_id = "${aws_vpc.site.id}"
}

resource "aws_route_table" "routing" {
  vpc_id = "${aws_vpc.site.id}"

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = "${aws_internet_gateway.gateway.id}"
  }
}

resource "aws_route_table_association" "route_assoc" {
  subnet_id      = "${aws_subnet.sub.id}"
  route_table_id = "${aws_route_table.routing.id}"
}
