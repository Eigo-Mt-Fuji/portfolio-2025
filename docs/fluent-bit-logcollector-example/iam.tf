resource "aws_iam_role" "ecs_task_execution_role" {
  name = "${var.env}-logcollector-task-execution-role"

  assume_role_policy = jsonencode({
    Version = "2012-10-17",
    Statement = [
      {
        Effect = "Allow",
        Principal = {
          Service = "ecs-tasks.amazonaws.com"
        },
        Action = "sts:AssumeRole"
      }
    ]
  })

  managed_policy_arns = [
    "arn:aws:iam::aws:policy/service-role/AmazonECSTaskExecutionRolePolicy",
    "arn:aws:iam::aws:policy/AmazonS3FullAccess"
  ]
}

resource "aws_iam_role" "ecs_instance_role" {
  name = "${var.env}-logcollector-instance-role"

  assume_role_policy = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Sid": "",
      "Effect": "Allow",
      "Action": "sts:AssumeRole",
      "Principal": {
        "Service": "ec2.amazonaws.com"
      }
    }
  ]
}
EOF
}

resource "aws_iam_role_policy_attachment" "ecs_for_ec2_role" {
  role       = aws_iam_role.ecs_instance_role.name
  policy_arn = "arn:aws:iam::aws:policy/service-role/AmazonEC2ContainerServiceforEC2Role"
  depends_on = [aws_iam_role.ecs_instance_role]
}
resource "aws_iam_role_policy_attachment" "ssm_managed_instance_core" {
  role       = aws_iam_role.ecs_instance_role.name
  policy_arn = "arn:aws:iam::aws:policy/AmazonSSMManagedInstanceCore"
  depends_on = [aws_iam_role.ecs_instance_role]
}

resource "aws_iam_instance_profile" "ecs_instance_role" {
  name = "${var.env}-logcollector-instance-profile"
  role = aws_iam_role.ecs_instance_role.name
}
resource "aws_iam_role" "terminate_lifecyclehook" {
  name        = "${var.env}-logcollector-lifecyclehook"
  description = "when the instance terminates, it publishes to sns with lifecyclehook of ASG"

  assume_role_policy = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Action": "sts:AssumeRole",
      "Principal": {
        "Service": "autoscaling.amazonaws.com"
      },
      "Effect": "Allow",
      "Sid": ""
    }
  ]
}
EOF


  force_detach_policies = true
}

resource "aws_iam_role_policy_attachment" "terminate_lifecyclehook" {
  role       = aws_iam_role.terminate_lifecyclehook.name
  policy_arn = "arn:aws:iam::aws:policy/service-role/AutoScalingNotificationAccessRole"
  depends_on = [aws_iam_role.terminate_lifecyclehook]
}

resource "aws_iam_role" "cloudformation_service_role" {
  name        = "${var.env}-logcollector-cloudformation"
  description = "Allows CloudFormation to create and manage AWS stacks and resources on your behalf."

  assume_role_policy = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Sid": "",
      "Effect": "Allow",
      "Principal": {
        "Service": "cloudformation.amazonaws.com"
      },
      "Action": "sts:AssumeRole"
    }
  ]
}
EOF
  force_detach_policies = true
}

resource "aws_iam_policy" "access_asgrole_policy" {
  name = "${var.env}-logcollector-cloudformation-access-asgrole"

  policy = <<EOF
{
    "Version": "2012-10-17",
    "Statement": [
        {
            "Effect": "Allow",
            "Action": [
                "iam:GetRole",
                "iam:PassRole",
                "autoscaling:DescribeAutoScalingGroups"
            ],
            "Resource": "*"
        }
    ]
}
EOF
}

resource "aws_iam_role_policy_attachment" "attach_ec2_full" {
  role       = aws_iam_role.cloudformation_service_role.name
  policy_arn = "arn:aws:iam::aws:policy/AmazonEC2FullAccess"
  depends_on = [aws_iam_role.cloudformation_service_role]
}

resource "aws_iam_role_policy_attachment" "attach_asg_full" {
  role       = aws_iam_role.cloudformation_service_role.name
  policy_arn = "arn:aws:iam::aws:policy/AutoScalingFullAccess"
  depends_on = [aws_iam_role.cloudformation_service_role]
}

resource "aws_iam_role_policy_attachment" "attach_iam_pass" {
  role       = aws_iam_role.cloudformation_service_role.name
  policy_arn = aws_iam_policy.access_asgrole_policy.arn
  depends_on = [aws_iam_role.cloudformation_service_role]
}