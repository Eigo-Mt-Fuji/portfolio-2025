variable "vpc_id" {
    default = "vpc-0e186c1a6164bd710"
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
    default = "ami-0eceb414529a60916"
}

variable "target_s3_bucket" {
    default = "devops-org-logs-dev"
}