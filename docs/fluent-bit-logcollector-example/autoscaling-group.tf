resource "aws_launch_template" "fluentbit" {
  name                   = "${var.env}-logcollector-ecs-asg"
  key_name               = "devops"
  image_id               = var.fluentbit_ec2_ami

  iam_instance_profile {
    name = aws_iam_role.ecs_instance_role.name
  }

  tag_specifications {
    resource_type = "instance"
    tags = { 
        Name = "fluentbit-ecs" 
        datadog  = "monitored"
    }
  }
  instance_type = "t3.micro"
  user_data = base64encode(templatefile("${path.module}/templates/autoscalinggroup/userdata.sh", { ecs_cluster = aws_ecs_cluster.fluentbit.name, stack_name  = "asg-fluentbit" }))
  credit_specification {
    cpu_credits = "unlimited"
  }
  monitoring {
    enabled = true
  }
  network_interfaces {
    associate_public_ip_address = true
    security_groups = var.security_groups
  }

  # https://docs.aws.amazon.com/AWSEC2/latest/UserGuide/block-device-mapping-concepts.html
  # Reserved for root volume	
  block_device_mappings {
    device_name = "/dev/xvda"
    ebs {
      volume_type = "gp2"
      volume_size = 30
      encrypted = false
      # TODO: delete_on_termination = false
      delete_on_termination = true
    }
  }
  ebs_optimized = false
}

resource "aws_cloudformation_stack" "fluentbit_asg" {
  name          = "asg-fluentbit"
  template_body = templatefile("${path.module}/templates/autoscalinggroup/config.yml", {
    stack_name                              = "asg-fluentbit"
    launchtemplate_name                     = aws_launch_template.fluentbit.name
    launchtemplate_varsion                  = aws_launch_template.fluentbit.latest_version
    autoscalinggroup_name                   = "fluentbit"
    target_group_arn = aws_lb_target_group.nlb_tg.arn
    max_batch_size                          = 1
    min_instances_in_service                = 1
    sns_role_arn = aws_iam_role.terminate_lifecyclehook.arn
    sns_target_arn = "arn:aws:sns:ap-northeast-1:047980477351:ecs_draining_instance-dev"
    availability_zone_1                     = "ap-northeast-1a"
    availability_zone_2                     = "ap-northeast-1c"
    vpc_zone_identifier_1                   = var.private_subnets[0]
    vpc_zone_identifier_2                   = var.private_subnets[1]
    desired_capacity                        = 1
    max_size                                = 1
    min_size                                = 1
    instance_types                          = "t3.micro"
  })

  iam_role_arn  = aws_iam_role.cloudformation_service_role.arn

  depends_on = [
    aws_launch_template.fluentbit,
    aws_iam_role_policy_attachment.terminate_lifecyclehook,
    aws_iam_role_policy_attachment.attach_iam_pass,
  ]
}