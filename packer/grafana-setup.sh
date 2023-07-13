#!/bin/bash

sudo apt-get update
sudo apt-get -y -qq install docker.io unzip

sudo docker run -d -p 3000:3000 grafana/grafana
sudo docker run -d -p 9090:9090 prom/prometheus