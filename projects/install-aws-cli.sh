#!/bin/bash
set -euo pipefail

# ----------------------------------------
# Script to install AWS CLI
# ----------------------------------------

# Detect package manager
if command -v yum >/dev/null 2>&1; then
    PKG_MANAGER="yum"
elif command -v apt >/dev/null 2>&1; then
    PKG_MANAGER="apt"
else
    echo "No supported package manager found (yum or apt)"
    exit 1
fi

#Function to remove existing  aws cli

check_existing_aws() {
	echo "Checking exisitng  AWS CLI "

    if command -v aws >/dev/null 2>&1; then
    	echo "AWS CLI already installed: $(aws --version)"
    	echo "Upgrading to latest version..."
else
    echo "AWS CLI not installed"
fi
}

install_awscli(){
	echo "Installing AWS CLI latest version on linux"

	# Download and install AWS CLI
	curl "https://awscli.amazonaws.com/awscli-exe-linux-x86_64.zip" -o "awscliv2.zip"
	
	if [[ $PKG_MANAGER == "yum" ]]; then
    		sudo yum install -y unzip
	elif [[ $PKG_MANAGER == "apt" ]]; then
    	sudo apt update -y
    	sudo apt install -y unzip
fi
	
	unzip awscliv2.zip
	sudo ./aws/install

	aws --version
	rm -rf awscliv2.zip ./aws
}

check_existing_aws || exit 1
install_awscli || exit 1
