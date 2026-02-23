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
	 if command -v aws >/dev/null 2>&1; then
        echo "AWS CLI already installed: $(aws --version)"
        echo "Upgrading to latest version..."
        sudo ./aws/install --update
    else
        echo "Installing AWS CLI..."
        sudo ./aws/install
    fi


	aws --version
	rm -rf awscliv2.zip ./aws
}

wait_for_instance() {
    local instance_id="$1"
    echo "Waiting for instance $instance_id to be in running state..."

    while true; do
        state=$(aws ec2 describe-instances --instance-ids "$instance_id" --query 'Reservations[0].Instances[0].State.Name' --output text)
        if [[ "$state" == "running" ]]; then
            echo "Instance $instance_id is now running."
            break
        fi
        sleep 10
    done
}
create_ec2_instance() {
    local ami_id="$1"
    local instance_type="$2"
    local key_name="$3"
    local subnet_id="$4"
    local security_group_ids="$5"
    local instance_name="$6"
# Run AWS CLI command to create EC2 instance
    instance_id=$(aws ec2 run-instances \
        --image-id "$ami_id" \
        --instance-type "$instance_type" \
        --key-name "$key_name" \
        --subnet-id "$subnet_id" \
        --security-group-ids "$security_group_ids" \
        --tag-specifications "ResourceType=instance,Tags=[{Key=Name,Value=$instance_name}]" \
        --query 'Instances[0].InstanceId' \
        --output text
    )
 if [[ -z "$instance_id" ]]; then
        echo "Failed to create EC2 instance." >&2
        exit 1
    fi

    echo "Instance $instance_id created successfully."

    # Wait for the instance to be in running state
    wait_for_instance "$instance_id"
}
main() {
	if command -v aws >/dev/null 2>&1; then
        echo "AWS CLI already installed: $(aws --version)"
        echo "Skipping installation."
    else
        install_awscli
    fi


    echo "Creating EC2 instance..."

    # Specify the parameters for creating the EC2 instance
    AMI_ID="ami-073130f74f5ffb161"
    INSTANCE_TYPE="t3.micro"
    KEY_NAME="SS_KEY"
    SUBNET_ID="subnet-05e9cf2cec5418bf2"
    SECURITY_GROUP_IDS="sg-084bf02e77d8bd3c5"  # Add your security group IDs separated by space
    INSTANCE_NAME="Shell-Script-EC2-Demo"

    # Call the function to create the EC2 instance
    create_ec2_instance "$AMI_ID" "$INSTANCE_TYPE" "$KEY_NAME" "$SUBNET_ID" "$SECURITY_GROUP_IDS" "$INSTANCE_NAME"

    echo "EC2 instance creation completed."
}

main "$@"


