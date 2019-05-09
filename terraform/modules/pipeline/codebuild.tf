/*resource "aws_codebuild_project" "coursework_app_builder" {
  name = "coursework-app-builder"
  description = "Builds coursework app"
  service_role = "${aws_iam_role.coursework_codebuild_role.arn}"
  
  environment = {
    compute_type = "BUILD_GENERAL1_SMALL"
    image = "aws/codebuild/standard:1.0"
    type = "LINUX_CONTAINER"
  }

  source = {
    type = "CODEPIPELINE"
  }

  artifacts = {
    type = "S3"
    encryptiom_disabled = true
    location = "${aws_s3_bucket.pipeline_bucket.bucket}"
    name = "coursework-app"
    namespace_type = "BUILD_ID"
    packaging ="NONE"
    path = "build-artifacts"
  }

  vpc_config {
      vpc_id = "${module.server.vpc_id}"
      subnets = [
          "${module.server.public_subnet_id}"
      ]
      security_group_ids = [
          "${module.server.all_traphic_sg_id}"
      ]
  }

  tags 
  {
      Name = "coursework_app_builder"
      aim = "coursework"
  }
}
*/