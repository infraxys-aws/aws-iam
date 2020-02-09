#set ($policyName = $instance.getAttribute("policy_name"))
#set ($roleName = $instance.parent.getAttribute("iam_role_name"))

resource "aws_iam_role_policy" "$policyName" {
  name = "$policyName"
  role = "#[[$]]#{aws_iam_role.${roleName}.id}"
  policy = <<EOF
$instance.getAttribute("policy")  
EOF
}
