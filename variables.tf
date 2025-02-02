variable "aws_region" {
  description = "The AWS region to deploy resources"
  default     = "us-east-1"
}

variable "container_image" {
  description = "The Docker image to deploy"
  default     = "nginx:latest"
}
