#set ($policyName = $instance.getAttribute("policy_name"))
#set ($roleName = $instance.parent.getAttribute("iam_role_name"))

data "aws_iam_policy" "$policyName" {
  arn = "arn:aws:iam::aws:policy/$policyName"
}

resource "aws_iam_role_policy_attachment" "${policyName}-attachment" {
  role = "${D}{aws_iam_role.${roleName}.id}"
  policy_arn = data.aws_iam_policy.${policyName}.arn
}