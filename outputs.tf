output "minio_server_ip" {
  value = aws_instance.minio.private_ip
}

output "worker_ip" {
  value = aws_instance.worker.private_ip
}

output "warp_ip" {
  value = aws_instance.warp.public_ip
}
