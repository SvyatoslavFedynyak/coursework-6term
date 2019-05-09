resource "aws_s3_bucket" "pipeline_bucket" {
  bucket = "coursework-pipeline-bucket-for-app-artifacts"
  acl    = "private"

  tags 
  {
      Name = "coursework_pipeline_bucket_for_app_artifacts"
      aim = "coursework"
  }
}

