resource "null_resource" "cluster" {
  count = var.env == "Prod" ? length(var.public_cidr) : 1

  provisioner "file" {
    source      = "user_data.sh"
    destination = "/tmp/user_data.sh"

    connection {
      type        = "ssh"
      user        = "ubuntu"
      private_key = file("Linux_secfile.pem")
      host        = element(aws_instance.public-instance[*].public_ip, count.index)
    }
  }

  provisioner "remote-exec" {
    inline = [
      "sudo chmod 777 /tmp/user_data.sh",
      "sudo /tmp/user_data.sh",
      "sudo apt update",
      "sudo apt install jq unzip -y",
    ]

    connection {
      type        = "ssh"
      user        = "ubuntu"
      private_key = file("Linux_secfile.pem")
      host        = element(aws_instance.public-instance[*].public_ip, count.index)
    }
  }
}
