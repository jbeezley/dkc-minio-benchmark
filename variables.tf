variable "public_key_path" {
  description = "Path to a public key used to ssh into the instances"
  default     = "~/.ssh/id_rsa.pub"
}

variable "private_key_path" {
  description = "Path to a private key for provisioning"
  default     = "~/.ssh/id_rsa"
}

variable "key_name" {
  default = "login-key"
}

variable "aws_region" {
  # changing this requires setting the ami
  default = "us-east-2"
}

variable "aws_ami" {
  default = "ami-0a63f96e85105c6d3"
}

variable "minio_server_instance" {
  default = "t2.micro"
}

variable "worker_instance" {
  default = "t2.micro"
}
