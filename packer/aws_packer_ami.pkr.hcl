packer {
  required_plugins {
    amazon = {
      version = ">= 0.0.1"
      source  = "github.com/hashicorp/amazon"
    }
  }
}

source "amazon-ebs" "base_west" {
  ami_name      = "packer-aws-image"
  instance_type = "t3.micro"
  region        = "eu-west-2"
  source_ami    = "ami-020737107b4baaa50"
  ssh_username  = "ec2-user"
}

build {
  name = "packer-golden-image"
  sources = [
    "source.amazon-ebs.base_west"
  ]

  provisioner "file"{
    source = "packer-config.sh"
    destination = "/home/ec2-user/packer-config.sh"
  }

  provisioner "shell" {
    inline = [
      "sudo cp /home/ec2-user/packer-config.sh /var/lib/cloud/scripts/per-boot/packer-config.sh",
      "sudo chmod +x /var/lib/cloud/scripts/per-boot/packer-config.sh",
      "rm /home/ec2-user/packer-config.sh",
    ]
  }

  post-processor "manifest" {
    output = "packer_manifest.json"
  }
  }
