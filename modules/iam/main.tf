resource "aws_iam_user" "user" {
  name = "project_${var.project_name}-${var.environment}"
}

resource "aws_iam_group" "group" {
  name = "project_${var.project_name}-${var.environment}"

}

resource "aws_iam_policy" "policy" {
  name        = "${var.bucket_name}.bucket"
  description = "Access to ${var.bucket_name} bucket"
  policy      = "${data.aws_iam_policy_document.policy.json}"
}

resource "aws_iam_policy_attachment" "attach" {
  name       = "attachment"
  groups     = ["${aws_iam_group.group.name}"]
  policy_arn = "${aws_iam_policy.policy.arn}"
}

data "aws_iam_policy_document" "policy" {
  statement {
    actions = [
      "s3:*"
    ]

    resources = [
      "arn:aws:s3:::${var.bucket_name}",
      "arn:aws:s3:::${var.bucket_name}/*",
    ]
  }
}

resource "aws_iam_group_membership" "group" {
  name = "tf-group-membership"

  users = [
    "${aws_iam_user.user.name}",
  ]

  group = "${aws_iam_group.group.name}"
}

resource "aws_iam_access_key" "user" {
  user    = "${aws_iam_user.user.name}"
}
