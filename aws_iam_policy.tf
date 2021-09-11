resource "aws_iam_policy" "albc" {
  name   = "AWSLoadBalancerControllerIAMPolicy-${random_string.suffix.result}"
  policy = data.http.albc_iam_policy_json.body
}
