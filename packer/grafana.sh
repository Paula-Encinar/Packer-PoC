#!/bin/bash

sudo docker run -d -p 3000:3000 grafana/grafana
sudo docker run -p 9090:9090 prom/prometheus