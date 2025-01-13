variable "vpc_id" {
    default = "vpc-0e186c1a6164bd710"
}

variable "env" {
    default = "dev"
}
variable "private_subnets" {
    default = ["subnet-00f9d1e641e28f1d2", "subnet-0a1db94da4cf37167"]
}
variable "nlb_subnet" {
    default = ["subnet-0a1db94da4cf37167"]
}
variable "security_groups" {
    default = ["sg-0b0f376f0f2096dcc"]
}

variable "fluentbit_ec2_ami" {
    # https://github.com/aws/amazon-ecs-ami/blob/main/CHANGELOG.md#20241217
    # al2023-ami-ecs-hvm-2023.0.20241217-kernel-6.1-arm64 https://ap-northeast-1.console.aws.amazon.com/ec2/home?region=ap-northeast-1#ImageDetails:imageId=ami-0f07b31ae158be656
    default = "ami-0f07b31ae158be656"
}
variable "fluentbit_ec2_instance_type" {
    default = "t4g.micro"
}
variable "target_s3_bucket" {
    default = "devops-org-logs-dev"
}