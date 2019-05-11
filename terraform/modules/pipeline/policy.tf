resource "aws_iam_role" "coursework_codebuild_role" {
  name = "coursework-codebuild-role"
  description = "Allow access to use codecommit and s3"

  assume_role_policy = "${file("../modules/pipeline/iam/roles/codebuild_role.json")}"

  tags 
  {
      Name = "coursework_codebuild_role"
      aim = "coursework"
  }
}
resource "aws_iam_role_policy_attachment" "s3_allow_for_codebuild" {
  role = "${aws_iam_role.coursework_codebuild_role.id}"
  policy_arn = "arn:aws:iam::aws:policy/AmazonS3FullAccess"
}
resource "aws_iam_role_policy_attachment" "codepipeline_allow_for_codebuild" {
  role = "${aws_iam_role.coursework_codebuild_role.id}"
  policy_arn = "arn:aws:iam::aws:policy/AWSCodePipelineFullAccess"
}


resource "aws_iam_role_policy_attachment" "vpc_allow_for_codebuild" {
  role = "${aws_iam_role.coursework_codebuild_role.id}"
  policy_arn = "arn:aws:iam::aws:policy/AmazonVPCFullAccess"
}

resource "aws_iam_role_policy_attachment" "cloudlock_allow_for_codebuild" {
  role = "${aws_iam_role.coursework_codebuild_role.id}"
  policy_arn = "arn:aws:iam::aws:policy/CloudWatchFullAccess"
}

resource "aws_iam_role" "codepipeline_role" {
  name = "codepipeline-role"
  assume_role_policy = "${file("../modules/pipeline/iam/roles/codepipeline_role.json")}"

  tags 
  {
      Name = "codepipeline_role"
      aim = "coursework"
  }
}

resource "aws_iam_role_policy_attachment" "s3_allow_for_codepipeline" {
  role = "${aws_iam_role.codepipeline_role.id}"
  policy_arn = "arn:aws:iam::aws:policy/AmazonS3FullAccess"
  depends_on = [
    "aws_iam_role.codepipeline_role"
  ]
}
resource "aws_iam_role_policy_attachment" "codepipeline_allow_for_codepipeline" {
  role = "${aws_iam_role.codepipeline_role.id}"
  policy_arn = "arn:aws:iam::aws:policy/AWSCodePipelineFullAccess"
  depends_on = [
    "aws_iam_role.codepipeline_role"
  ]
}


resource "aws_iam_role_policy_attachment" "vpc_allow_for_codepipeline" {
  role = "${aws_iam_role.codepipeline_role.id}"
  policy_arn = "arn:aws:iam::aws:policy/AmazonVPCFullAccess"
  depends_on = [
    "aws_iam_role.codepipeline_role"
  ]
}

resource "aws_iam_role_policy_attachment" "codebuild_allow_for_codepipeline" {
  role = "${aws_iam_role.codepipeline_role.id}"
  policy_arn = "arn:aws:iam::aws:policy/AWSCodeBuildAdminAccess"
  depends_on = [
    "aws_iam_role.codepipeline_role"
  ]
}
