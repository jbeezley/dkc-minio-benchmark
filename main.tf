provider "aws" {
  profile = "default"
  version = "~> 2.0"
  region = var.aws_region
}

terraform {
  backend "s3" {
    bucket = "dkc-minio-benchmark-tf-state"
    key = "default"
    region = "us-east-1"
  }
}

resource "aws_key_pair" "auth" {
  key_name   = var.key_name
  public_key = file(var.public_key_path)
}

resource "aws_instance" "minio" {
  instance_type = var.minio_server_instance
  ami = var.aws_ami
  key_name = aws_key_pair.auth.id
  vpc_security_group_ids = [aws_security_group.default.id]
  subnet_id = aws_subnet.default.id

  # provisioner "remote-exec" {
  #   inline = [
  #     "sudo apt-get -y update",
  #     "sudo apt-get -y install apt-transport-https ca-certificates curl gnupg-agent software-properties-common",
  #     "curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo apt-key add -"
  #     "sudo apt-get -y update",
  #     "sudo apt-get install docker-ce docker-ce-cli containerd.io",
  #   ]
  # }
}

resource "aws_instance" "worker" {
  instance_type = var.worker_instance
  ami = var.aws_ami
  key_name = aws_key_pair.auth.id
  vpc_security_group_ids = [aws_security_group.default.id]
  subnet_id = aws_subnet.default.id

  # provisioner "remote-exec" {
  #   inline = [
  #     "sudo apt-get -y update",
  #     "sudo apt-get -y install apt-transport-https ca-certificates curl gnupg-agent software-properties-common",
  #     "curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo apt-key add -"
  #     "sudo apt-get -y update",
  #     "sudo apt-get install docker-ce docker-ce-cli containerd.io",
  #   ]
  # }
}