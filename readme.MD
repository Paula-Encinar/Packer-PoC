# Packer + Terraform + CI/CD PoC

This repository is a Proof of Concept in which we will use three tools mentioned below to automate the creation of an EC2 instance in AWS from a customised AMI so that when the EC2 instance is started, a graphana service and a prometheus service are created from docker. 

- [Tools used](#tools-used)
- [Poc Overview and Usage](#poc-overview-and-usage)
- [Workflow](#workflow)

## Tools used 

- [Packer](https://www.packer.io/) is one of the open-source tools developed by HashiCorp. Packer is a tool for creating machine images in this case an  Amazon Machine Image from a single source configuration. It allows you to define machine image templates as code with a default configuration to be used when a machine with that AMI is lifted.
- [Terraform](https://www.terraform.io/) is an open-source infrastructure as code (IaC) tool developed by HashiCorp. It is designed to help automate and manage the provisioning and configuration of infrastructure resources across various cloud providers in this case use Amazon Web Service as a Cloud Provider. Terraform allows you to define your infrastructure using declarative configuration files, and then it handles the process of creating, updating, and deleting resources to match the desired state defined in those files.
- [Github actions](https://docs.github.com/en/actions) is an automation and continuous integration/continuous deployment (CI/CD) platform provided by GitHub. It allows developers to automate various tasks, workflows, and processes directly within their GitHub repositories. With GitHub Actions, you can build, test, and deploy your code, as well as perform other custom automation tasks, all in response to events and triggers like code pushes, pull requests, and more.
- [Amazon Web Service (AWS)](https://aws.amazon.com/) is a comprehensive and widely used cloud computing platform provided by Amazon.com. It offers a broad set of cloud-based services, including virtual machine (EC2), storage (s3 bucket),networking, security, and more. AWS allows organizations to access and utilize these services over the internet, providing scalable, flexible, and cost-effective solutions for a wide range of IT needs.

## PoC Overview and Usage 



## Workflow