resource "aws_codecommit_repository" "pipeline_source" {
  repository_name = "coursework-repo"
  description = "Repository for coursework app"
}
