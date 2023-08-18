#!/bin/bash

sudo yum update -y
sudo yum install docker -y

sudo systemctl enable docker --now
sudo usermod -a -G docker ec2-user

sudo docker run -d -p 3000:3000 grafana/grafana
sudo docker run -d -p 9090:9090 prom/prometheus