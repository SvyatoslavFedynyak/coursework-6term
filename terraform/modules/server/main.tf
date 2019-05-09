resource "aws_instance" "tomcat_server" {
  instance_type = "t2.micro"
  ami = "${var.ami}"
  key_name = "${var.key}"
  instance_initiated_shutdown_behavior = "stop"

  network_interface = {
    network_interface_id = "${aws_network_interface.tomcat_server_ni.id}"
    device_index = 0
    delete_on_termination = false
  }
  volume_tags = {
    size = 10
    Name = "tomcat server volume"
      aim = "coursework"
  }
  tags 
  {
      Name = "tomcat server"
      aim = "coursework"
  }
  depends_on =
  [
      "aws_network_interface.tomcat_server_ni"
  ]
}