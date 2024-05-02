resource "aws_iam_user" "vrt_user" {
  name = var.vrt_username
}

resource "aws_iam_user_policy_attachment" "attach_vrt_user" {
  user       = aws_iam_user.vrt_user.name
  policy_arn = var.iam_policy_arns
}

resource "aws_iam_access_key" "vrt_iam_keys" {
  user       = var.vrt_username
  depends_on = [aws_iam_user.vrt_user]
}
