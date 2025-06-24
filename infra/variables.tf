variable "aws_region" {
  default = "us-east-1"
}

variable "project_name" {
  default = "devops-app"
}

variable "backend_image" {
  description = "ECR Image URL for backend"
}

variable "frontend_image" {
  description = "ECR Image URL for frontend"
}

