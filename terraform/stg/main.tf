provider "aws" {
  region = "eu-central-1"
}

module "server" {
  source = "../modules/server"
  vpc_id = "${module.server.vpc_id}"
  public_subnet_id = "${module.server.public_subnet_id}"
  all_traphic_sg_id = "${module.server.all_traphic_sg_id}"
}

module "pipeline" {
  source = "../modules/pipeline"
}


