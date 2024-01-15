resource "aws_efs_file_system" "jenkins-data" {
  creation_token   = "var-lib-jenkins"
  performance_mode = "generalPurpose"
  throughput_mode  = "bursting"

  tags = local.common_tags
}

resource "aws_efs_mount_target" "jenkins-targets" {
  file_system_id  = aws_efs_file_system.jenkins-data.id
  subnet_id       = aws_subnet.kthamel-ec2-subnet-0.id
  security_groups = [aws_security_group.public-subnet-assoc.id]
}

resource "null_resource" "configure-efs" {
  depends_on = [aws_efs_mount_target.jenkins-targets]
  connection {
    type        = "ssh"
    user        = "ec2-user"
    private_key = local_file.private_key_pem.filename
    host        = aws_instance.jenkins-instance.public_ip
  }
}
