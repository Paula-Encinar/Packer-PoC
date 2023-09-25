# Packer + Terraform + CI/CD PoC

This repository is a Proof of Concept in which we will use three tools mentioned below to automate the creation of an EC2 instance in AWS from a customised AMI so that when the EC2 instance is started, a graphana service and a prometheus service are created from docker. 

- [Tools used](#tools-used)
- [Installation](#installation)
- [Poc Overview and Usage](#poc-overview-and-usage)
- [Workflow](#workflow)

## Tools used 

- [Packer](https://www.packer.io/) is one of the open-source tools developed by HashiCorp. Packer is a tool for creating machine images in this case an  Amazon Machine Image from a single source configuration. It allows you to define machine image templates as code with a default configuration to be used when a machine with that AMI is lifted.
- [Terraform](https://www.terraform.io/) is an open-source infrastructure as code (IaC) tool developed by HashiCorp. It is designed to help automate and manage the provisioning and configuration of infrastructure resources across various cloud providers in this case use Amazon Web Service as a Cloud Provider. Terraform allows you to define your infrastructure using declarative configuration files, and then it handles the process of creating, updating, and deleting resources to match the desired state defined in those files.
- [Github actions](https://docs.github.com/en/actions) is an automation and continuous integration/continuous deployment (CI/CD) platform provided by GitHub. It allows developers to automate various tasks, workflows, and processes directly within their GitHub repositories. With GitHub Actions, you can build, test, and deploy your code, as well as perform other custom automation tasks, all in response to events and triggers like code pushes, pull requests, and more.
- [Amazon Web Service (AWS)](https://aws.amazon.com/) is a comprehensive and widely used cloud computing platform provided by Amazon.com. It offers a broad set of cloud-based services, including virtual machine (EC2), storage (s3 bucket),networking, security, and more. AWS allows organizations to access and utilize these services over the internet, providing scalable, flexible, and cost-effective solutions for a wide range of IT needs.

## Installation

In macOs the best way is to use [Brew](https://brew.sh/), so you should have Brew installed in your machine, in the first place.

The packages to be used are now installed with a series of commands. First, install the HashiCorp tap, a repository of all our Homebrew packages.

``` bash
brew tap hashicorp/tap
```

Now, install Packer with the following command:

``` bash
brew install hashicorp/tap/packer
```

Now, install Terraform with the following command:

``` bash
brew install hashicorp/tap/terraform
```

Finally, the AWS CLI package is installed in case you want to run something locally and not via Github actions.
  
  ``` bash
  curl "https://awscli.amazonaws.com/AWSCLIV2.pkg" -o "AWSCLIV2.pkg"
  sudo installer -pkg AWSCLIV2.pkg -target /
  ```

## Workflow

The workflow of this PoC is as follows:


```mermaid
flowchart TD
A[Packer creates new AMI on AWS] --> B(An S3 bucket is created with Terraform)
B --> C[Load output packer.json file in s3 bucket]
C --> D[Copy AMI id from packer.json in s3 and add to terraform.tfvars file]
D --> E[Terraform creates EC2 instance with AMI id]

```


## PoC Overview and Usage 

As I mentioned in the introduction, this is a proof of concept in which three main tools are used: Packer, Terraform and Github Actions, and Amazon Web Service (AWS) has been used as Cloud. 

First of all, all the steps mentioned below in the workflow are performed through Github actions and bash script to raise and drop EC2 instances, s3 buckets and create and delete AMIs. Nothing is executed manually! 

First you have to decide on which Amazon Machine Image you want to build with Packer. To do this you need to log into AWS and choose an AMI, in this case an *ubuntu focal 20.04* has been chosen.

After selecting the AMI, Packer will build a custom AMI by provisioning it from a script in which this new AMI is configured so that when it is deployed to an EC2 instance it will have the expected configuration. The script has been done in bash and consists of installing and updating packages to build two Docker services which will be Grafana and Prometheus.Packer copies this file into the machine right into the path where every time a new machine is started with that AMI it will run that script. You can see it in this sample piece of code from my Packer file: 

``` bash
  provisioner "shell" {
    inline = [
      "sudo cp /home/ec2-user/packer-config.sh /var/lib/cloud/scripts/per-boot/packer-config.sh",
      "sudo chmod +x /var/lib/cloud/scripts/per-boot/packer-config.sh",
      "rm /home/ec2-user/packer-config.sh",
    ]
  }
```

If you want to check the complete configuration of the packer file you can find it here: 

```bash
packer/aws_packer_ami.pkr.hcl
```

If you want to review the complete configuration of the provisioning file that Packer uses, you can view it here: 

```bash
packer/packer-config.sh
```

As you can see in the workflow of the previous section, Packer when it finishes creating the AMI stores in ouput a json file where you can get the ID of the new AMI, this file is stored in a S3 bucket and then copies this ID in the terraform.tfvars file to create later the EC2 instance with that AMI from a script that you can find in the following path: 

```bash
scripts/packer-terraform.sh
```

As you can see this script has two things of uses, the use case all, with which you perform the upload to the s3 bucket and get the new id of the AMI. On the other hand there is the destroy use case, which takes care of cleaning up both the newly created AMI and its snapshot in case the infrastructure is destroyed, but we'll talk about that later. 

In case you want to run this script for any of the two cases manually for local testing you have to add to the run command the case you want to use, below you can see an example: 

```bash
./scripts/packer-terraform.sh all
```


