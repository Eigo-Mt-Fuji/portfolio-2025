```
    terraform apply "terraform.tfplan"
eigofujikawa@EigoFujawanoMBP fluent-bit-logcollector-example % terraform apply "terraform.tfplan"
aws_ecr_repository.fluentbit: Creating...
aws_iam_role.terminate_lifecyclehook: Creating...
aws_iam_policy.access_asgrole_policy: Creating...
aws_iam_role.ecs_task_execution_role: Creating...
aws_iam_role.ecs_instance_role: Creating...
aws_iam_role.cloudformation_service_role: Creating...
aws_lb_target_group.nlb_tg: Creating...
aws_lb.nlb: Creating...
aws_ecr_repository.fluentbit: Creation complete after 0s [id=dev-fluentbit]
null_resource.default: Creating...
null_resource.default: Provisioning with 'local-exec'...
null_resource.default (local-exec): Executing: ["/bin/sh" "-c" "cd templates/fluentbit && sh ./build.sh dev"]
aws_lb_target_group.nlb_tg: Creation complete after 1s [id=arn:aws:elasticloadbalancing:ap-northeast-1:047980477351:targetgroup/dev-logcollector-tg/938ea65831b9a3ca]
aws_iam_policy.access_asgrole_policy: Creation complete after 1s [id=arn:aws:iam::047980477351:policy/dev-logcollector-cloudformation-access-asgrole]
aws_iam_role.terminate_lifecyclehook: Creation complete after 1s [id=dev-logcollector-lifecyclehook]
aws_iam_role_policy_attachment.terminate_lifecyclehook: Creating...
aws_iam_role.ecs_instance_role: Creation complete after 1s [id=dev-logcollector-instance-role]
aws_iam_role_policy_attachment.ssm_managed_instance_core: Creating...
aws_iam_role_policy_attachment.ecs_for_ec2_role: Creating...
aws_iam_instance_profile.ecs_instance_role: Creating...
aws_iam_role.cloudformation_service_role: Creation complete after 2s [id=dev-logcollector-cloudformation]
aws_iam_role_policy_attachment.attach_asg_full: Creating...
aws_iam_role_policy_attachment.attach_iam_pass: Creating...
aws_iam_role_policy_attachment.attach_ec2_full: Creating...
aws_iam_role_policy_attachment.terminate_lifecyclehook: Creation complete after 1s [id=dev-logcollector-lifecyclehook-20250113121717767700000002]
aws_iam_role_policy_attachment.ssm_managed_instance_core: Creation complete after 1s [id=dev-logcollector-instance-role-20250113121717733600000001]
aws_iam_role_policy_attachment.ecs_for_ec2_role: Creation complete after 1s [id=dev-logcollector-instance-role-20250113121717767800000003]
aws_iam_role_policy_attachment.attach_asg_full: Creation complete after 0s [id=dev-logcollector-cloudformation-20250113121718186000000004]
aws_iam_role.ecs_task_execution_role: Creation complete after 2s [id=dev-logcollector-task-execution-role]
aws_iam_role_policy_attachment.attach_iam_pass: Creation complete after 0s [id=dev-logcollector-cloudformation-20250113121718271200000005]
aws_iam_role_policy_attachment.attach_ec2_full: Creation complete after 1s [id=dev-logcollector-cloudformation-20250113121718272500000006]
null_resource.default (local-exec): Login Succeeded
aws_iam_instance_profile.ecs_instance_role: Creation complete after 2s [id=dev-logcollector-instance-profile]
null_resource.default (local-exec): #0 building with "desktop-linux" instance using docker driver

null_resource.default (local-exec): #1 [internal] load .dockerignore
null_resource.default (local-exec): #1 transferring context: 2B done
null_resource.default (local-exec): #1 DONE 0.0s

null_resource.default (local-exec): #2 [internal] load build definition from Dockerfile
null_resource.default (local-exec): #2 transferring dockerfile: 159B done
null_resource.default (local-exec): #2 DONE 0.0s

null_resource.default (local-exec): #3 [internal] load metadata for docker.io/fluent/fluent-bit:3.2.4
null_resource.default (local-exec): #3 DONE 2.5s

null_resource.default (local-exec): #4 [1/2] FROM docker.io/fluent/fluent-bit:3.2.4@sha256:a185ac0516e1f35568ff0662f12c4ada0ea38c4300ed223d0fde485599dff5b5
null_resource.default (local-exec): #4 DONE 0.0s

null_resource.default (local-exec): #5 [internal] load build context
null_resource.default (local-exec): #5 transferring context: 74B done
null_resource.default (local-exec): #5 DONE 0.0s

null_resource.default (local-exec): #6 [2/2] COPY ./fluent-bit.yaml /fluent-bit/etc/fluent-bit.yaml
null_resource.default (local-exec): #6 CACHED

null_resource.default (local-exec): #7 exporting to image
null_resource.default (local-exec): #7 exporting layers done
null_resource.default (local-exec): #7 writing image sha256:f401d7ab8fa58d2c07a8d52f12af556d30dccafb0be9a88bff04eb55e4bc7ff5 done
null_resource.default (local-exec): #7 naming to 047980477351.dkr.ecr.ap-northeast-1.amazonaws.com/dev-fluentbit:latest done
null_resource.default (local-exec): #7 DONE 0.0s
null_resource.default (local-exec): The push refers to repository [047980477351.dkr.ecr.ap-northeast-1.amazonaws.com/dev-fluentbit]
null_resource.default (local-exec): 9ec43e06490f: Preparing
null_resource.default (local-exec): 572b2913f5ef: Preparing
null_resource.default (local-exec): 500e1a03b9db: Preparing
null_resource.default (local-exec): 9de7c1828c57: Preparing
null_resource.default (local-exec): 737ad12a8e7a: Preparing
null_resource.default (local-exec): 85636e663163: Preparing
null_resource.default (local-exec): e4a1b8676947: Preparing
null_resource.default (local-exec): cd61646a1aba: Preparing
null_resource.default (local-exec): 2cab0696a551: Preparing
null_resource.default (local-exec): b336e209998f: Preparing
null_resource.default (local-exec): f4aee9e53c42: Preparing
null_resource.default (local-exec): 1a73b54f556b: Preparing
null_resource.default (local-exec): 2a92d6ac9e4f: Preparing
null_resource.default (local-exec): bbb6cacb8c82: Preparing
null_resource.default (local-exec): 6f1cdceb6a31: Preparing
null_resource.default (local-exec): af5aa97ebe6c: Preparing
null_resource.default (local-exec): 4d049f83d9cf: Preparing
null_resource.default (local-exec): a80545a98dcd: Preparing
null_resource.default (local-exec): 8fa10c0194df: Preparing
null_resource.default (local-exec): fcab13f8f829: Preparing
null_resource.default (local-exec): b336e209998f: Waiting
null_resource.default (local-exec): f4aee9e53c42: Waiting
null_resource.default (local-exec): 1a73b54f556b: Waiting
null_resource.default (local-exec): 2a92d6ac9e4f: Waiting
null_resource.default (local-exec): bbb6cacb8c82: Waiting
null_resource.default (local-exec): 6f1cdceb6a31: Waiting
null_resource.default (local-exec): af5aa97ebe6c: Waiting
null_resource.default (local-exec): 4d049f83d9cf: Waiting
null_resource.default (local-exec): a80545a98dcd: Waiting
null_resource.default (local-exec): 8fa10c0194df: Waiting
null_resource.default (local-exec): fcab13f8f829: Waiting
null_resource.default (local-exec): 85636e663163: Waiting
null_resource.default (local-exec): e4a1b8676947: Waiting
null_resource.default (local-exec): cd61646a1aba: Waiting
null_resource.default (local-exec): 2cab0696a551: Waiting
null_resource.default (local-exec): 500e1a03b9db: Pushed
null_resource.default (local-exec): 9ec43e06490f: Pushed
null_resource.default (local-exec): 737ad12a8e7a: Pushed
null_resource.default (local-exec): 9de7c1828c57: Pushed
null_resource.default (local-exec): 85636e663163: Pushed
null_resource.default (local-exec): e4a1b8676947: Pushed
null_resource.default (local-exec): cd61646a1aba: Pushed
null_resource.default (local-exec): 572b2913f5ef: Pushed
null_resource.default (local-exec): 2cab0696a551: Pushed
null_resource.default (local-exec): b336e209998f: Pushed
null_resource.default (local-exec): f4aee9e53c42: Pushed
null_resource.default (local-exec): 1a73b54f556b: Pushed
null_resource.default (local-exec): 2a92d6ac9e4f: Pushed
null_resource.default (local-exec): af5aa97ebe6c: Pushed
null_resource.default (local-exec): 6f1cdceb6a31: Pushed
null_resource.default (local-exec): bbb6cacb8c82: Pushed
null_resource.default (local-exec): 4d049f83d9cf: Pushed
aws_lb.nlb: Still creating... [10s elapsed]
null_resource.default: Still creating... [10s elapsed]
null_resource.default (local-exec): fcab13f8f829: Pushed
null_resource.default (local-exec): a80545a98dcd: Pushed
null_resource.default (local-exec): 8fa10c0194df: Pushed
null_resource.default (local-exec): latest: digest: sha256:bd8114b5683452092ae8bdd40dd764176268955afaa3c842b541b789103e18cc size: 4493
null_resource.default: Creation complete after 13s [id=3394540213140223424]
aws_ecs_cluster.fluentbit: Creating...
aws_lb.nlb: Still creating... [20s elapsed]
aws_ecs_cluster.fluentbit: Still creating... [10s elapsed]
aws_ecs_cluster.fluentbit: Creation complete after 10s [id=arn:aws:ecs:ap-northeast-1:047980477351:cluster/dev-logcollector]
aws_launch_template.fluentbit: Creating...
aws_launch_template.fluentbit: Creation complete after 1s [id=lt-0c72f3ec1109dad4d]
aws_cloudformation_stack.fluentbit_asg: Creating...
aws_lb.nlb: Still creating... [30s elapsed]
aws_cloudformation_stack.fluentbit_asg: Still creating... [10s elapsed]
aws_lb.nlb: Still creating... [40s elapsed]
aws_cloudformation_stack.fluentbit_asg: Still creating... [20s elapsed]
aws_lb.nlb: Still creating... [50s elapsed]
aws_cloudformation_stack.fluentbit_asg: Still creating... [30s elapsed]
aws_lb.nlb: Still creating... [1m0s elapsed]
aws_cloudformation_stack.fluentbit_asg: Still creating... [40s elapsed]
aws_lb.nlb: Still creating... [1m10s elapsed]
aws_cloudformation_stack.fluentbit_asg: Still creating... [50s elapsed]
aws_lb.nlb: Still creating... [1m20s elapsed]
aws_cloudformation_stack.fluentbit_asg: Creation complete after 56s [id=arn:aws:cloudformation:ap-northeast-1:047980477351:stack/dev-asg-logcollector/61e51a10-d1a8-11ef-aa13-067f399c1f79]
aws_lb.nlb: Still creating... [1m30s elapsed]
aws_lb.nlb: Still creating... [1m40s elapsed]
aws_lb.nlb: Still creating... [1m50s elapsed]
aws_lb.nlb: Still creating... [2m0s elapsed]
aws_lb.nlb: Still creating... [2m10s elapsed]
aws_lb.nlb: Still creating... [2m20s elapsed]
aws_lb.nlb: Creation complete after 2m22s [id=arn:aws:elasticloadbalancing:ap-northeast-1:047980477351:loadbalancer/net/dev-logcollector-nlb/24effb26fb29126b]
aws_lb_listener.nlb_listener: Creating...
aws_lb_listener.nlb_listener: Creation complete after 0s [id=arn:aws:elasticloadbalancing:ap-northeast-1:047980477351:listener/net/dev-logcollector-nlb/24effb26fb29126b/2cd9e922b12c1bc8]
╷
│ Error: Provider produced inconsistent final plan
│ 
│ When expanding the plan for aws_ecs_task_definition.fluentbit to include new values
│ learned so far during apply, provider "registry.terraform.io/hashicorp/aws" produced an
│ invalid new value for .container_definitions: was cty.StringVal(""), but now
│ cty.StringVal("[{\"Command\":null,\"Cpu\":0,\"CredentialSpecs\":null,\"DependsOn\":null,\"DisableNetworking\":null,\"DnsSearchDomains\":null,\"DnsServers\":null,\"DockerLabels\":null,\"DockerSecurityOptions\":null,\"EntryPoint\":null,\"Environment\":[{\"Name\":\"TARGET_S3_BUCKET\",\"Value\":\"devops-org-logs-dev\"}],\"EnvironmentFiles\":null,\"Essential\":true,\"ExtraHosts\":null,\"FirelensConfiguration\":null,\"HealthCheck\":{\"Command\":[\"CMD-SHELL\",\"exit
│ 0\"],\"Interval\":60,\"Retries\":3,\"StartPeriod\":10,\"Timeout\":10},\"Hostname\":null,\"Image\":\"047980477351.dkr.ecr.ap-northeast-1.amazonaws.com/dev-fluentbit:latest\",\"Interactive\":null,\"Links\":null,\"LinuxParameters\":null,\"LogConfiguration\":null,\"Memory\":null,\"MemoryReservation\":null,\"MountPoints\":[{\"ContainerPath\":\"/fluent-bit/logs\",\"ReadOnly\":null,\"SourceVolume\":\"logs\"}],\"Name\":\"fluentbit\",\"PortMappings\":[{\"AppProtocol\":\"\",\"ContainerPort\":10224,\"ContainerPortRange\":null,\"HostPort\":null,\"Name\":null,\"Protocol\":\"\"}],\"Privileged\":null,\"PseudoTerminal\":null,\"ReadonlyRootFilesystem\":null,\"RepositoryCredentials\":null,\"ResourceRequirements\":null,\"Secrets\":null,\"StartTimeout\":null,\"StopTimeout\":null,\"SystemControls\":null,\"Ulimits\":null,\"User\":null,\"VolumesFrom\":null,\"WorkingDirectory\":null}]").
│ 
│ This is a bug in the provider, which should be reported in the provider's own issue
│ tracker.
╵
eigofujikawa@EigoFujawanoMBP fluent-bit-logcollector-example % terraform plan -out=terraform.tfplan
aws_iam_role.ecs_task_execution_role: Refreshing state... [id=dev-logcollector-task-execution-role]
aws_iam_role.cloudformation_service_role: Refreshing state... [id=dev-logcollector-cloudformation]
aws_iam_role.terminate_lifecyclehook: Refreshing state... [id=dev-logcollector-lifecyclehook]
aws_iam_role.ecs_instance_role: Refreshing state... [id=dev-logcollector-instance-role]
aws_ecr_repository.fluentbit: Refreshing state... [id=dev-fluentbit]
aws_iam_policy.access_asgrole_policy: Refreshing state... [id=arn:aws:iam::047980477351:policy/dev-logcollector-cloudformation-access-asgrole]
aws_lb.nlb: Refreshing state... [id=arn:aws:elasticloadbalancing:ap-northeast-1:047980477351:loadbalancer/net/dev-logcollector-nlb/24effb26fb29126b]
aws_lb_target_group.nlb_tg: Refreshing state... [id=arn:aws:elasticloadbalancing:ap-northeast-1:047980477351:targetgroup/dev-logcollector-tg/938ea65831b9a3ca]
null_resource.default: Refreshing state... [id=3394540213140223424]
aws_lb_listener.nlb_listener: Refreshing state... [id=arn:aws:elasticloadbalancing:ap-northeast-1:047980477351:listener/net/dev-logcollector-nlb/24effb26fb29126b/2cd9e922b12c1bc8]
aws_ecs_cluster.fluentbit: Refreshing state... [id=arn:aws:ecs:ap-northeast-1:047980477351:cluster/dev-logcollector]
aws_iam_role_policy_attachment.terminate_lifecyclehook: Refreshing state... [id=dev-logcollector-lifecyclehook-20250113121717767700000002]
aws_iam_role_policy_attachment.attach_ec2_full: Refreshing state... [id=dev-logcollector-cloudformation-20250113121718272500000006]
aws_iam_role_policy_attachment.attach_asg_full: Refreshing state... [id=dev-logcollector-cloudformation-20250113121718186000000004]
aws_iam_role_policy_attachment.attach_iam_pass: Refreshing state... [id=dev-logcollector-cloudformation-20250113121718271200000005]
aws_iam_role_policy_attachment.ssm_managed_instance_core: Refreshing state... [id=dev-logcollector-instance-role-20250113121717733600000001]
aws_iam_role_policy_attachment.ecs_for_ec2_role: Refreshing state... [id=dev-logcollector-instance-role-20250113121717767800000003]
aws_iam_instance_profile.ecs_instance_role: Refreshing state... [id=dev-logcollector-instance-profile]
aws_launch_template.fluentbit: Refreshing state... [id=lt-0c72f3ec1109dad4d]
aws_cloudformation_stack.fluentbit_asg: Refreshing state... [id=arn:aws:cloudformation:ap-northeast-1:047980477351:stack/dev-asg-logcollector/61e51a10-d1a8-11ef-aa13-067f399c1f79]

Terraform used the selected providers to generate the following execution plan. Resource
actions are indicated with the following symbols:
  + create

Terraform will perform the following actions:

  # aws_ecs_service.fluentbit_service will be created
  + resource "aws_ecs_service" "fluentbit_service" {
      + cluster                            = "arn:aws:ecs:ap-northeast-1:047980477351:cluster/dev-logcollector"
      + deployment_maximum_percent         = 200
      + deployment_minimum_healthy_percent = 100
      + desired_count                      = 1
      + enable_ecs_managed_tags            = false
      + enable_execute_command             = false
      + iam_role                           = (known after apply)
      + id                                 = (known after apply)
      + launch_type                        = "EC2"
      + name                               = "dev-logcollector-service"
      + platform_version                   = (known after apply)
      + scheduling_strategy                = "REPLICA"
      + tags_all                           = (known after apply)
      + task_definition                    = (known after apply)
      + triggers                           = (known after apply)
      + wait_for_steady_state              = false

      + load_balancer {
          + container_name   = "fluentbit"
          + container_port   = 10224
          + target_group_arn = "arn:aws:elasticloadbalancing:ap-northeast-1:047980477351:targetgroup/dev-logcollector-tg/938ea65831b9a3ca"
            # (1 unchanged attribute hidden)
        }
    }

  # aws_ecs_task_definition.fluentbit will be created
  + resource "aws_ecs_task_definition" "fluentbit" {
      + arn                      = (known after apply)
      + arn_without_revision     = (known after apply)
      + container_definitions    = jsonencode(
            [
              + {
                  + Command                = null
                  + Cpu                    = 0
                  + CredentialSpecs        = null
                  + DependsOn              = null
                  + DisableNetworking      = null
                  + DnsSearchDomains       = null
                  + DnsServers             = null
                  + DockerLabels           = null
                  + DockerSecurityOptions  = null
                  + EntryPoint             = null
                  + Environment            = [
                      + {
                          + Name  = "TARGET_S3_BUCKET"
                          + Value = "devops-org-logs-dev"
                        },
                    ]
                  + EnvironmentFiles       = null
                  + Essential              = true
                  + ExtraHosts             = null
                  + FirelensConfiguration  = null
                  + HealthCheck            = {
                      + Command     = [
                          + "CMD-SHELL",
                          + "exit 0",
                        ]
                      + Interval    = 60
                      + Retries     = 3
                      + StartPeriod = 10
                      + Timeout     = 10
                    }
                  + Hostname               = null
                  + Image                  = "047980477351.dkr.ecr.ap-northeast-1.amazonaws.com/dev-fluentbit:latest"
                  + Interactive            = null
                  + Links                  = null
                  + LinuxParameters        = null
                  + LogConfiguration       = null
                  + Memory                 = null
                  + MemoryReservation      = null
                  + MountPoints            = [
                      + {
                          + ContainerPath = "/fluent-bit/logs"
                          + ReadOnly      = null
                          + SourceVolume  = "logs"
                        },
                    ]
                  + Name                   = "fluentbit"
                  + PortMappings           = [
                      + {
                          + AppProtocol        = ""
                          + ContainerPort      = 10224
                          + ContainerPortRange = null
                          + HostPort           = null
                          + Name               = null
                          + Protocol           = ""
                        },
                    ]
                  + Privileged             = null
                  + PseudoTerminal         = null
                  + ReadonlyRootFilesystem = null
                  + RepositoryCredentials  = null
                  + ResourceRequirements   = null
                  + Secrets                = null
                  + StartTimeout           = null
                  + StopTimeout            = null
                  + SystemControls         = null
                  + Ulimits                = null
                  + User                   = null
                  + VolumesFrom            = null
                  + WorkingDirectory       = null
                },
            ]
        )
      + cpu                      = "256"
      + execution_role_arn       = "arn:aws:iam::047980477351:role/dev-logcollector-task-execution-role"
      + family                   = "dev-logcollector-task"
      + id                       = (known after apply)
      + memory                   = "512"
      + network_mode             = (known after apply)
      + requires_compatibilities = [
          + "EC2",
        ]
      + revision                 = (known after apply)
      + skip_destroy             = false
      + tags_all                 = (known after apply)
      + track_latest             = false

      + volume {
          + configure_at_launch = (known after apply)
          + host_path           = "/var/logs/fluent-bit"
          + name                = "logs"
        }
    }

Plan: 2 to add, 0 to change, 0 to destroy.

───────────────────────────────────────────────────────────────────────────────────────────

Saved the plan to: terraform.tfplan

To perform exactly these actions, run the following command to apply:
    terraform apply "terraform.tfplan"
eigofujikawa@EigoFujawanoMBP fluent-bit-logcollector-example % terraform apply "terraform.tfplan"
aws_ecs_task_definition.fluentbit: Creating...
aws_ecs_task_definition.fluentbit: Creation complete after 0s [id=dev-logcollector-task]
aws_ecs_service.fluentbit_service: Creating...
aws_ecs_service.fluentbit_service: Creation complete after 1s [id=arn:aws:ecs:ap-northeast-1:047980477351:service/dev-logcollector/dev-logcollector-service]

Apply complete! Resources: 2 added, 0 changed, 0 destroyed.
eigofujikawa@EigoFujawanoMBP fluent-bit-logcollector-example % 
```



```
eigofujikawa@EigoFujawanoMBP fluent-bit-logcollector % terraform apply "terraform.tfplan"
aws_iam_role_policy_attachment.attach_ec2_full: Destroying... [id=dev-logcollector-cloudformation-20250113121718272500000006]
aws_iam_role_policy_attachment.ecs_for_ec2_role: Destroying... [id=dev-logcollector-instance-role-20250113121717767800000003]
aws_iam_role_policy_attachment.attach_asg_full: Destroying... [id=dev-logcollector-cloudformation-20250113121718186000000004]
aws_iam_role_policy_attachment.ssm_managed_instance_core: Destroying... [id=dev-logcollector-instance-role-20250113121717733600000001]
aws_cloudformation_stack.fluentbit_asg: Destroying... [id=arn:aws:cloudformation:ap-northeast-1:047980477351:stack/dev-asg-logcollector/61e51a10-d1a8-11ef-aa13-067f399c1f79]
aws_lb_listener.nlb_listener: Destroying... [id=arn:aws:elasticloadbalancing:ap-northeast-1:047980477351:listener/net/dev-logcollector-nlb/24effb26fb29126b/2cd9e922b12c1bc8]
aws_ecs_service.fluentbit_service: Destroying... [id=arn:aws:ecs:ap-northeast-1:047980477351:service/dev-logcollector/dev-logcollector-service]
aws_lb_listener.nlb_listener: Destruction complete after 0s
aws_lb.nlb: Destroying... [id=arn:aws:elasticloadbalancing:ap-northeast-1:047980477351:loadbalancer/net/dev-logcollector-nlb/24effb26fb29126b]
aws_iam_role_policy_attachment.ecs_for_ec2_role: Destruction complete after 0s
aws_iam_role_policy_attachment.attach_ec2_full: Destruction complete after 0s
aws_iam_role_policy_attachment.attach_asg_full: Destruction complete after 0s
aws_iam_role_policy_attachment.ssm_managed_instance_core: Destruction complete after 0s
aws_cloudformation_stack.fluentbit_asg: Still destroying... [id=arn:aws:cloudformation:ap-northeast-1:0...r/61e51a10-d1a8-11ef-aa13-067f399c1f79, 10s elapsed]
aws_ecs_service.fluentbit_service: Still destroying... [id=arn:aws:ecs:ap-northeast-1:047980477351...-logcollector/dev-logcollector-service, 10s elapsed]
aws_lb.nlb: Still destroying... [id=arn:aws:elasticloadbalancing:ap-northea.../dev-logcollector-nlb/24effb26fb29126b, 10s elapsed]
aws_cloudformation_stack.fluentbit_asg: Still destroying... [id=arn:aws:cloudformation:ap-northeast-1:0...r/61e51a10-d1a8-11ef-aa13-067f399c1f79, 20s elapsed]
aws_ecs_service.fluentbit_service: Still destroying... [id=arn:aws:ecs:ap-northeast-1:047980477351...-logcollector/dev-logcollector-service, 20s elapsed]
aws_lb.nlb: Still destroying... [id=arn:aws:elasticloadbalancing:ap-northea.../dev-logcollector-nlb/24effb26fb29126b, 20s elapsed]
aws_ecs_service.fluentbit_service: Still destroying... [id=arn:aws:ecs:ap-northeast-1:047980477351...-logcollector/dev-logcollector-service, 30s elapsed]
aws_lb.nlb: Still destroying... [id=arn:aws:elasticloadbalancing:ap-northea.../dev-logcollector-nlb/24effb26fb29126b, 30s elapsed]
aws_ecs_service.fluentbit_service: Still destroying... [id=arn:aws:ecs:ap-northeast-1:047980477351...-logcollector/dev-logcollector-service, 40s elapsed]
aws_lb.nlb: Still destroying... [id=arn:aws:elasticloadbalancing:ap-northea.../dev-logcollector-nlb/24effb26fb29126b, 40s elapsed]
aws_lb.nlb: Destruction complete after 47s
aws_ecs_service.fluentbit_service: Still destroying... [id=arn:aws:ecs:ap-northeast-1:047980477351...-logcollector/dev-logcollector-service, 50s elapsed]
aws_ecs_service.fluentbit_service: Still destroying... [id=arn:aws:ecs:ap-northeast-1:047980477351...-logcollector/dev-logcollector-service, 1m0s elapsed]
aws_ecs_service.fluentbit_service: Still destroying... [id=arn:aws:ecs:ap-northeast-1:047980477351...-logcollector/dev-logcollector-service, 1m10s elapsed]
aws_ecs_service.fluentbit_service: Still destroying... [id=arn:aws:ecs:ap-northeast-1:047980477351...-logcollector/dev-logcollector-service, 1m20s elapsed]
aws_ecs_service.fluentbit_service: Still destroying... [id=arn:aws:ecs:ap-northeast-1:047980477351...-logcollector/dev-logcollector-service, 1m30s elapsed]
aws_ecs_service.fluentbit_service: Still destroying... [id=arn:aws:ecs:ap-northeast-1:047980477351...-logcollector/dev-logcollector-service, 1m40s elapsed]
aws_ecs_service.fluentbit_service: Still destroying... [id=arn:aws:ecs:ap-northeast-1:047980477351...-logcollector/dev-logcollector-service, 1m50s elapsed]
aws_ecs_service.fluentbit_service: Still destroying... [id=arn:aws:ecs:ap-northeast-1:047980477351...-logcollector/dev-logcollector-service, 2m0s elapsed]
aws_ecs_service.fluentbit_service: Still destroying... [id=arn:aws:ecs:ap-northeast-1:047980477351...-logcollector/dev-logcollector-service, 2m10s elapsed]
aws_ecs_service.fluentbit_service: Still destroying... [id=arn:aws:ecs:ap-northeast-1:047980477351...-logcollector/dev-logcollector-service, 2m20s elapsed]
aws_ecs_service.fluentbit_service: Still destroying... [id=arn:aws:ecs:ap-northeast-1:047980477351...-logcollector/dev-logcollector-service, 2m30s elapsed]
aws_ecs_service.fluentbit_service: Still destroying... [id=arn:aws:ecs:ap-northeast-1:047980477351...-logcollector/dev-logcollector-service, 2m40s elapsed]
aws_ecs_service.fluentbit_service: Still destroying... [id=arn:aws:ecs:ap-northeast-1:047980477351...-logcollector/dev-logcollector-service, 2m50s elapsed]
aws_ecs_service.fluentbit_service: Still destroying... [id=arn:aws:ecs:ap-northeast-1:047980477351...-logcollector/dev-logcollector-service, 3m0s elapsed]
aws_ecs_service.fluentbit_service: Still destroying... [id=arn:aws:ecs:ap-northeast-1:047980477351...-logcollector/dev-logcollector-service, 3m10s elapsed]
aws_ecs_service.fluentbit_service: Still destroying... [id=arn:aws:ecs:ap-northeast-1:047980477351...-logcollector/dev-logcollector-service, 3m20s elapsed]
aws_ecs_service.fluentbit_service: Destruction complete after 3m29s
aws_ecs_task_definition.fluentbit: Destroying... [id=dev-logcollector-task]
aws_ecs_task_definition.fluentbit: Destruction complete after 0s
aws_iam_role.ecs_task_execution_role: Destroying... [id=dev-logcollector-task-execution-role]
aws_iam_role.ecs_task_execution_role: Destruction complete after 2s
╷
│ Error: waiting for CloudFormation Stack (arn:aws:cloudformation:ap-northeast-1:047980477351:stack/dev-asg-logcollector/61e51a10-d1a8-11ef-aa13-067f399c1f79) delete: stack status (DELETE_FAILED): The following resource(s) failed to delete: [AutoScalingGroup]. 
│ Resource handler returned message: "User: arn:aws:sts::047980477351:assumed-role/dev-logcollector-cloudformation/AWSCloudFormation is not authorized to perform: autoscaling:DescribeScalingActivities because no identity-based policy allows the autoscaling:DescribeScalingActivities action (Service: AutoScaling, Status Code: 403, Request ID: 5c3ed75e-7983-49b7-8a21-eb8380dd4977)" (RequestToken: 90329db8-2587-5976-5abd-a292fb4e23ac, HandlerErrorCode: AccessDenied)
```
