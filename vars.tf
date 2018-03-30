variable "w_aws_region" {
  default = "eu-central-1"
}

variable "aws_amis" {
  # https://docs.aws.amazon.com/AmazonECS/latest/developerguide/ecs-optimized_AMI.html
  default = {
    "eu-central-1" = "ami-ac055447"
  }
}
