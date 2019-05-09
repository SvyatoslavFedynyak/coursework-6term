variable "availability_zone" {
  default = "eu-central-1a"
}
variable "ami" {
  default = "ami-09def150731bdbcc2"
}

variable "key" {
  default = "svyatoslav_own_key"
}

variable "vpc_id" {}
variable "public_subnet_id" {} 
variable  "all_traphic_sg_id" {}