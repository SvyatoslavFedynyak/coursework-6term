output "vpc_id" {
  value = "${aws_vpc.pipeline_vpc.id}"
}
output "public_subnet_id" {
  value = "${aws_subnet.public_subnet.id}"
}
output "all_traphic_sg_id" {
  value = "${aws_security_group.all_traphic_sg.id}"
}