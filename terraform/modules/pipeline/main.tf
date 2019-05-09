/*resource "aws_codepipeline" "pipeline" {
  name = "coursework-pipeline"
  role_arn = "${aws_iam_role.codepipeline_role.arn}"

  artifact_store {
      location = "${aws_s3_bucket.pipeline_bucket}"
      type = "S3"
  }

  stage {
      name = "Source"

      action {
          name = "Source"
          category = "Source"
          owner = "AWS"
          provider = "CodeCommit"
          version = 1
      }
  }

  depends_on = [
      "aws_iam_role.codepipeline_role", 
      "aws_iam_role_policy.codepipeline_policy",
      "aws_s3_bucket.pipeline_bucket",
      "aws_codecommit_repository.pipeline_source"

  ]
}*/
