resource "aws_codebuild_project" "coursework_app_builder" {
  name = "coursework-app-builder"
  description = "Builds coursework app"
  service_role = "${aws_iam_role.coursework_codebuild_role.arn}"
  build_timeout = 5
  
  environment = {
    compute_type = "BUILD_GENERAL1_SMALL"
    image = "aws/codebuild/standard:1.0"
    type = "LINUX_CONTAINER"

    environment_variable = [
      {
        "name" = "GITHUB_TOKEN"
        "value" = "${file("../../github-token")}"
      }
    ]
  }

  source = {
    type = "GITHUB"
    buildspec = "${file("../modules/pipeline/data/buildspec.yml")}"
    location = "https://github.com/SvyatoslavFedynyak/oms"
  }

  artifacts = {
    type = "S3"
    name = "Build-arts"
    encryption_disabled = true
    location = "${aws_s3_bucket.pipeline_bucket.bucket}"
    namespace_type = "BUILD_ID"
    packaging ="NONE"
    path = "build-artifacts"
  }

  vpc_config {
      vpc_id = "${var.vpc_id}"
      subnets = [
          "${var.public_subnet_id}"
      ]
      security_group_ids = [
          "${var.all_traphic_sg_id}"
      ]
  }

  tags 
  {
      Name = "coursework_app_builder"
      aim = "coursework"
  }
}
