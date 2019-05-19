output "vpc_id" {
  value = "${aws_vpc.pipeline_vpc.id}"
}
output "public_subnet_id" {
  value = "${aws_subnet.public_subnet.id}"
}
output "all_traphic_sg_id" {
  value = "${aws_security_group.all_traphic_sg.id}"
}

output "instance_public_ip" {
  value = "${aws_instance.tomcat_server.public_ip}"
}

output "instance_id" {
  value = "${aws_instance.tomcat_server.id}"
}

output "instance_state" {
  value = "${aws_instance.tomcat_server.instance_state}"
}


