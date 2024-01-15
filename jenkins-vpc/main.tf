resource "tls_private_key" "ssh_key" {
  algorithm = "RSA"
}

resource "local_file" "private_key_pem" {
  content  = tls_private_key.ssh_key.private_key_pem
  filename = "ec2_ssh_key.pem"
}

resource "aws_key_pair" "ssh_key_pub" {
  key_name   = "ec2_ssh_key"
  public_key = tls_private_key.ssh_key.public_key_openssh

  lifecycle {
    ignore_changes = [key_name]
  }
}

resource "aws_instance" "jenkins-instance" {
  ami             = "ami-079db87dc4c10ac91"
  subnet_id       = aws_subnet.kthamel-ec2-subnet-0.id
  security_groups = [aws_security_group.public-subnet-assoc.id]
  instance_type   = "t2.micro"
  key_name        = aws_key_pair.ssh_key_pub.key_name

  user_data = <<-EOF
#!/bin/bash
## Install dependencies ##
sudo yum install git -y
## Clone the jenskins configurations ##
sudo git clone https://github.com/kthamel/aws-jenkins-configuration.git
## Setup jenkins master server ## 
sudo bash aws-jenkins-configuration/script.sh

EOF

  connection {
    user        = "ec2-user"
    private_key = tls_private_key.ssh_key.private_key_pem
    host        = self.public_ip
  }

  provisioner "local-exec" {
    command = "chmod 0400 ${local_file.private_key_pem.filename}"
  }

  provisioner "remote-exec" {
    inline = [
      "sudo mkdir -p /var/lib/jenkins",
      "sudo yum install nfs-utils -y -q"
    ]
  }

  tags = local.common_tags
}

output "ssh-instance-eip" {
  description = "Public IP of Vault Instance"
  value       = aws_instance.jenkins-instance.public_ip
}
