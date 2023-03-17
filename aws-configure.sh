#!/bin/bash
AWS_CLI=$(aws --version)
echo "$AWS_CLI"
if [ -z "$AWS_CLI" ]
then
    echo "AWS_CLI is Not Installed please wait while we are installing it"
    echo Please Input exact OS_TYPE : 'Windows' , 'macOS', 'Linux ARM', 'Linux x86 64-bit'.
    read OS_TYPE

    case "$OS_TYPE" in
    "Windows") echo "installing AWS CLI for windows python_3x and pip3 required"
    pip3 install awscliv2

    echo Please provide aws_access_key_id
    read AWS_ACCESS_KEY_ID

    echo Please provide aws_secret_access_key
    read AWS_ACCESS_KEY_SECRET

    echo Please provide AWS_REGION
    read AWS_REGION

    echo Please provide OUTPUT_TYPE 'json' or 'text'
    read OUTPUT_TYPE

    aws configure set aws_access_key_id "$AWS_ACCESS_KEY_ID" && aws configure set aws_secret_access_key "$AWS_ACCESS_KEY_SECRET"  && aws configure set region "$AWS_REGION" && aws configure set output "${OUTPUT_TYPE}"
    ;;
    "macOS") echo "installing AWS CLI for macOS if you hv SUDO permissions"
    curl "https://awscli.amazonaws.com/AWSCLIV2.pkg" -o "AWSCLIV2.pkg"
    sudo installer -pkg AWSCLIV2.pkg -target /

    echo Please provide aws_access_key_id
    read AWS_ACCESS_KEY_ID

    echo Please provide aws_secret_access_key
    read AWS_ACCESS_KEY_SECRET

    echo Please provide AWS_REGION
    read AWS_REGION

    echo Please provide OUTPUT_TYPE 'json' or 'text'
    read OUTPUT_TYPE

    aws configure set aws_access_key_id "$AWS_ACCESS_KEY_ID" && aws configure set aws_secret_access_key "$AWS_ACCESS_KEY_SECRET"  && aws configure set region "$AWS_REGION" && aws configure set output "${OUTPUT_TYPE}"
    ;;
    "Linux x86 64-bit") echo "installing AWS CLI for Linux x86 64-bit"
    curl "https://awscli.amazonaws.com/awscli-exe-linux-x86_64.zip" -o "awscliv2.zip"
    unzip awscliv2.zip
    sudo ./aws/install

    echo Please provide aws_access_key_id
    read AWS_ACCESS_KEY_ID

    echo Please provide aws_secret_access_key
    read AWS_ACCESS_KEY_SECRET

    echo Please provide AWS_REGION
    read AWS_REGION

    echo Please provide OUTPUT_TYPE 'json' or 'text'
    read OUTPUT_TYPE

    aws configure set aws_access_key_id "$AWS_ACCESS_KEY_ID" && aws configure set aws_secret_access_key "$AWS_ACCESS_KEY_SECRET"  && aws configure set region "$AWS_REGION" && aws configure set output "${OUTPUT_TYPE}"
    ;;
    "Linux ARM") echo "installing AWS CLI for Linux ARM"
    curl "https://awscli.amazonaws.com/awscli-exe-linux-aarch64.zip" -o "awscliv2.zip"
    unzip awscliv2.zip
    sudo ./aws/install

    echo Please provide aws_access_key_id
    read AWS_ACCESS_KEY_ID

    echo Please provide aws_secret_access_key
    read AWS_ACCESS_KEY_SECRET

    echo Please provide AWS_REGION
    read AWS_REGION

    echo Please provide OUTPUT_TYPE 'json' or 'text'
    read OUTPUT_TYPE

    aws configure set aws_access_key_id "$AWS_ACCESS_KEY_ID" && aws configure set aws_secret_access_key "$AWS_ACCESS_KEY_SECRET"  && aws configure set region "$AWS_REGION" && aws configure set output "${OUTPUT_TYPE}"
    ;;
    esac
else
      echo "$AWS_CLI is already installed so we are moving forward to create infra !!"
fi

