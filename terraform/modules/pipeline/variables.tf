variable vpc_id {}
variable public_subnet_id {}
variable all_traphic_sg_id {}

variable "source-repo-https" {
  default = "https://github.com/SvyatoslavFedynyak/oms.git"
}
variable "source-repo-ssh" {
  default = "git@github.com:SvyatoslavFedynyak/oms.git"
}
