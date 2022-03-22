variable "ec2_should_be_created" {
  description = "Should the EC2 be created?"
  type        = bool
  default     = true
}

variable "ec2_count" {
  description = "Number of Instances"
  type        = number
  default     = 1
}

variable "min_size" {
  type        = number
  default     = 1
}

variable "max_size" {
  type        = number
  default     = 2
}

variable "ec2_name" {
  description = "EC2 Name"
  type        = string
  default     = "fiap-hmv-service"
}

variable "http_port" {
  description = "The port the will be listening"
  type        = number
  default     = 8080
}

variable "elb_port" {
  description = "The port the elb will be listening"
  type        = number
  default     = 80
}

variable "server_port" {
  description = "The port the web server will be listening"
  type        = number
  default     = 8080
}

variable "ec2_key_name" {
  description = "Key pair name"
  type        = string
  default     = "fiap-hmv-key-pair"
}

variable "ec2_ami" {
  description = "The Amazon Machine Image"
  type        = string
  default     = "ami-0c02fb55956c7d316" # Amazon Linux 2 AMI (HVM) - Kernel 5.10, SSD Volume Type
}

variable "ec2_instance_type" {
  description = "The EC2 Instance type"
  type        = string
  default     = "t2.micro"
}

variable "projeto" {
  description = "Nome do projeto"
  type        = string
  default     = "FIAP-HMV"
}

variable "autoscaling_enabled" {
  description = "Should the Auto Scaling be configured?"
  type        = string
  default     = "true"
}



# variable "ec2_security_group_name" {
#   description = "The Name of the EC2 Security Group"
#   type        = string
#   default     = "Free Tier EC2 Security Group"
# }

# variable "ec2_security_group_description" {
#   description = "The Description of the EC2 Security Group"
#   type        = string
#   default     = "Free Tier EC2 Security Group"
# }

# variable "vpc_id" {
#   description = "The ID of the VPC"
#   type        = string
# }

# variable "public_subnet_id" {
#   description = "The ID of the Public Subnet"
#   type        = string
# }

# variable "ec2_ssh_key_name" {
#   description = "The SSH Key Name"
#   type        = string
#   default     = "free-tier-ec2-key"
# }

# variable "ec2_ssh_public_key_path" {
#   description = "The local path to the SSH Public Key"
#   type        = string
# }

