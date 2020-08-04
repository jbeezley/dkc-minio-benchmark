provider "aws" {
  profile = "default"
  version = "~> 2.0"
  region  = var.aws_region
}

terraform {
  backend "s3" {
    bucket = "dkc-minio-benchmark-tf-state"
    key    = "default"
    region = "us-east-1"
  }
}

resource "aws_key_pair" "auth" {
  key_name   = var.key_name
  public_key = file(var.public_key_path)
}

resource "aws_instance" "minio" {
  instance_type          = var.minio_server_instance
  ami                    = var.aws_ami
  key_name               = aws_key_pair.auth.id
  vpc_security_group_ids = [aws_security_group.main.id]
  subnet_id              = aws_subnet.default.id
  private_ip             = "10.0.1.10"

  tags = {
    Name = "minio"
  }

  root_block_device {
    volume_size = "100"
  }

  connection {
    type = "ssh"
    user = "ubuntu"
    host = aws_instance.minio.public_ip
  }

  provisioner "remote-exec" {
    inline = [
      "sudo apt-get -y update",
      "sudo apt-get -y install docker.io",
      "sudo usermod -a -G docker ubuntu"
    ]
  }

  provisioner "file" {
    source      = "minio-server.sh"
    destination = "/home/ubuntu/minio-server.sh"

  }

  provisioner "remote-exec" {
    inline = [
      "chmod +x /home/ubuntu/minio-server.sh",
      "/home/ubuntu/minio-server.sh"
    ]
  }
}

resource "aws_instance" "warp" {
  instance_type          = var.warp_server_instance
  ami                    = var.aws_ami
  key_name               = aws_key_pair.auth.id
  vpc_security_group_ids = [aws_security_group.main.id]
  subnet_id              = aws_subnet.default.id

  tags = {
    Name = "warp"
  }

  connection {
    type = "ssh"
    user = "ubuntu"
    host = aws_instance.warp.public_ip
  }

  provisioner "remote-exec" {
    inline = [
      "sudo apt-get -y update",
      "sudo apt-get -y install docker.io",
      "sudo usermod -a -G docker ubuntu"
    ]
  }
}
