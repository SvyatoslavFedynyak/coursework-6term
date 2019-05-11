resource "aws_codepipeline" "pipeline" {
  name     = "coursework-pipeline"
  role_arn = "${aws_iam_role.codepipeline_role.arn}"

  artifact_store {
    location = "${aws_s3_bucket.pipeline_bucket.bucket}"
    type     = "S3"
  }

  stage {
    name = "Source"

    action {
      name             = "Source"
      category         = "Source"
      owner            = "ThirdParty"
      provider         = "GitHub"
      output_artifacts = ["code"]
      version          = 1

      configuration {
        Owner  = "SvyatoslavFedynyak"
        Repo   = "oms"
        Branch = "aws"
        OAuthToken = "${file("../../github-token")}"
        PollForSourceChanges = true
      }
    }
  }

  stage {
    name = "Build"

    action {
      name             = "Build"
      category         = "Build"
      owner            = "AWS"
      provider         = "CodeBuild"
      input_artifacts  = ["code"]
      output_artifacts = ["package"]
      version          = 1

      configuration {
        ProjectName = "${aws_codebuild_project.coursework_app_builder.name}"
      }
    }
  }

  depends_on = [
    "aws_iam_role.codepipeline_role",
    "aws_s3_bucket.pipeline_bucket",
    "aws_codebuild_project.coursework_app_builder",
  ]
}
