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
resource "aws_iam_role_policy_attachment" "codecommit_allow_for_codebuild" {
  role = "${aws_iam_role.coursework_codebuild_role.id}"
  policy_arn = "arn:aws:iam::aws:policy/AWSCodeCommitFullAccess"
}

/*resource "aws_iam_role" "codepipeline_role" {
  name = "codepipeline-role"
  assume_role_policy = "${file(policies/role.json)}"

  tags 
  {
      Name = "codepipeline_role"
      aim = "coursework"
  }
}

resource "aws_iam_role_policy" "codepipeline_policy" {
  name = "codepipeline-policy"
  role = "${aws_iam_role.codepipeline_role.id}"
  policy = "${file("policies/policy.json")}"
  

  tags 
  {
      Name = "codepipeline_policy"
      aim = "coursework"
  }
}
*/