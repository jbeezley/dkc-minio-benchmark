output "minio_server_private_ip" {
  value = aws_instance.minio.private_ip
}

output "minio_server_public_ip" {
  value = aws_instance.minio.public_ip
}

output "warp_ip" {
  value = aws_instance.warp.public_ip
}
