# Setup Kubeedge environment setup using script

This repository contains two Bash scripts for setting up Docker, KubeEdge, Kind, and Kubectl on an Ubuntu system.

## Script 1: Edgecore installation

This script installs Docker and keadm on an egde system.

## Script 2: Cloudcore installation

This script installs Kind, keadm and kubectl on an cloudcore system.

## To setup CloudCore run the script on the CloudCore system
```sh 
chmod +x cloudcore_setup.sh
sudo ./cloudcore_setup.sh
```

## To setup EdgeCore run the script on the Edge system
```sh 
chmod +x edgecore_setup.sh
sudo ./edgecore_setup.sh
```
