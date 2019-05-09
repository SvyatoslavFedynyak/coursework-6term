resource "aws_vpc" "pipeline_vpc" {
    cidr_block = "192.168.144.0/24"

  tags 
  {
      Name = "pipeline_vpc"
      aim = "coursework"
  }

}

resource "aws_subnet" "public_subnet" {
  cidr_block = "192.168.144.0/24"
  vpc_id = "${aws_vpc.pipeline_vpc.id}"
  availability_zone = "${var.availability_zone}"
  map_public_ip_on_launch = true

  tags 
  {
      Name = "public_subnet"
      aim = "coursework"
  }
  depends_on = [
      "aws_vpc.pipeline_vpc"
  ]
}

resource "aws_security_group" "basic_web_sg" {
  name = "Basiv web security group"
  vpc_id = "${aws_vpc.pipeline_vpc.id}"
  description = "Security group with main web protocols white list"
  ingress = {
  from_port = 22
  to_port = 22
  protocol = "tcp"
  cidr_blocks = ["0.0.0.0/0"]
  }

  ingress = {
  from_port = 80
  to_port = 80
  protocol = "tcp"
  cidr_blocks = ["0.0.0.0/0"]
  }

  ingress = {
  from_port = 443
  to_port = 443
  protocol = "tcp"
  cidr_blocks = ["0.0.0.0/0"]
  }

  ingress = {
  from_port = 8080
  to_port = 8080
  protocol = "tcp"
  cidr_blocks = ["0.0.0.0/0"]
  }

  ingress = {
  from_port = 3306
  to_port = 3306
  protocol = "tcp"
  cidr_blocks = ["0.0.0.0/0"]
  }


  egress = {
    from_port = 0
    to_port = 0
    protocol = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags 
  {
      Name = "basic_web_sg"
      aim = "coursework"
  }
  depends_on = [
      "aws_vpc.pipeline_vpc"
  ]
}

resource "aws_security_group" "all_traphic_sg" {
  vpc_id = "${aws_vpc.pipeline_vpc.id}"
  name = "All traphic allow"
  description = "All trafic allow"
  ingress = {
    from_port = 0
    to_port = 0
    protocol = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress = {
    from_port = 0
    to_port = 0
    protocol = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags 
  {
      Name = "all_traphic_sg"
      aim = "coursework"
  }
}

resource "aws_internet_gateway" "gw" {
  vpc_id = "${aws_vpc.pipeline_vpc.id}"

  tags = {
    Name = "pipeline_gw"
    aim = "coursework"
  }
}

resource "aws_route_table" "pipeline_rt" {
  vpc_id = "${aws_vpc.pipeline_vpc.id}"

  route {
      cidr_block = "0.0.0.0/0"
      gateway_id = "${aws_internet_gateway.gw.id}"
  }

tags 
  {
      Name = "pipeline_rt"
      aim = "coursework"
  }
}
resource "aws_network_interface" "tomcat_server_ni" {
  subnet_id = "${aws_subnet.public_subnet.id}"
  security_groups = [
      "${aws_security_group.basic_web_sg.id}"
  ]
  tags 
  {
      Name = "tomcat_server_ni"
      aim = "coursework"
  }
  depends_on = 
  [
      "aws_subnet.public_subnet"
  ]
}



