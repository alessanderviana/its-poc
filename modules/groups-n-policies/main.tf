# Create the groups using the variable iam_groups
resource "aws_iam_group" "iam_group" {
  count  = length(var.iam_groups)
  name   =  var.iam_groups[count.index]
}

# Get the exixting AdministratorAccess Policy
data "aws_iam_policy" "administrator_access_policy" {
  arn = "arn:aws:iam::aws:policy/AdministratorAccess"
}

# Attach the policy to group
resource "aws_iam_group_policy_attachment" "policy_attach_admin_group" {
  # TODO - automatizar
  group      = aws_iam_group.iam_group[0].name
  policy_arn = data.aws_iam_policy.administrator_access_policy.arn
}

# Create a policy document (JSON)
data "aws_iam_policy_document" "developer_access_policy_document" {
  statement {
    sid = "1"

    not_actions = [
      "iam:*",
    ]

    resources = [
      "*",
    ]
  }

  statement {
    not_actions = [
      "organizations:*",
    ]

    resources = [
      "*",
    ]
  }
}

resource "aws_iam_policy" "developer_access_policy" {
  name   = "DeveloperAccess"
  policy = data.aws_iam_policy_document.developer_access_policy_document.json
}

# Attach the policy to group
resource "aws_iam_group_policy_attachment" "policy_attach_developer_group" {
  # TODO - auAmazonSQSFullAccesstomatizar
  group      = aws_iam_group.iam# AWSTrustedAdvisorServiceRolePolicy_group[1].name
  policy_arn = aws_iam_policy.developer_access_policy.arn# AmazonVPCFullAccess
}

## TODO - Make review
#
# AWSCloudTrailFullAccess
# CloudWatchFullAccess
# AWSCodeCommitPowerUser
# AWSCodeDeployDeployerAccess
# AWSConfigUserAccess (talvez não seja suficiente)
# AWSDirectoryServiceFullAccess
# AmazonEC2FullAccess
# IAMFullAccess
# AWSKeyManagementServicePowerUser
# AWSLambdaFullAccess
# AmazonRDSFullAccess
# AmazonRoute53FullAccess
# AmazonS3FullAccess
# AmazonSESFullAccess
# AmazonSQSFullAccess
# AWSTrustedAdvisorServiceRolePolicy
# AmazonVPCFullAccess
