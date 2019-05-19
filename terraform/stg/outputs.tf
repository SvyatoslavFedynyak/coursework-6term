output "server_ip" {
  value = "${module.server.instance_public_ip}"
}
output "server_instance_id" {
  value = "${module.server.instance_id}"
}

output "server_state" {
  value = "${module.server.instance_state}"
}

output "build_proj_id" {
  value = "${module.pipeline.codebuild_id}"
}

