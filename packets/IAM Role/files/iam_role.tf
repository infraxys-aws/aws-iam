#set ($iamRoleName = $instance.getAttribute("iam_role_name"))
#set ($useForInstanceProfile = $instance.getAttribute("use_for_instance_profile"))

resource "aws_iam_role" "$iamRoleName" {
    name = "$iamRoleName"
    path = "/"
#if ($useForInstanceProfile == "1")
    assume_role_policy = <<EOF
{
   "Version": "2012-10-17",
    "Statement" : [
       {
          "Action" : ["sts:AssumeRole"],
          "Effect" : "Allow",
          "Principal" : {
            "Service": ["ec2.amazonaws.com"]
          }
       }
    ]
}
EOF
#end
}

#if ($useForInstanceProfile == "1")
resource "aws_iam_instance_profile" "$iamRoleName" {
  name = "${iamRoleName}"
  role = aws_iam_role.${iamRoleName}.name
}
#end
