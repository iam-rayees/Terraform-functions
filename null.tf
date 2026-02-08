resource "null_resource" "cluster" {
  count = var.environment == "production" ? 3 : 2
  provisioner "file" {
    source      = "user_data.sh"
    destination = "/tmp/user_data.sh"
  }

  connection {
    type        = "ssh"
    user        = "ubuntu"
    private_key = file("Linux_secfile.pem")
    host        = element(aws_instance.public_instances[*].public_ip, count.index)
  }

  provisioner "remote-exec" {
    inline = [
      "sudo chmod 777 /tmp/user_data.sh",
      "sudo /tmp/user_data.sh",
      "sudo apt update",
      "sudo apt install jq unzip -y"
    ]

    connection {
      type        = "ssh"
      user        = "ubuntu"
      private_key = file("Linux_secfile.pem")
      host        = element(aws_instance.public_instances[*].public_ip, count.index)
    }
  }

  provisioner "local-exec" {
    command = "powershell -Command \"Write-Output 'EC2 Public IP: ${element(aws_instance.public_instances[*].public_ip, count.index)}'\""
  }

}

