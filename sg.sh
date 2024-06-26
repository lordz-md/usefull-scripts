PROFILE=default

command -v aws &>/dev/null
if [[ $? -ne 0 ]]; then
    echo "Please install aws-cli"
    exit 1
fi

GROUP_IDS=(sg-1111111 sg-2222222 sg-3333333)

export AWS_PAGER=""
for GROUP_ID in "${GROUP_IDS[@]}"; do

    aws --profile $PROFILE ec2 describe-network-interfaces \
        --max-items 1000 \
        --query 'NetworkInterfaces[*].{PrivateIpAddress:PrivateIpAddress,SubnetId:SubnetId,Description:Description,InstanceId:Attachment.InstanceId}' \
        --filters "Name=group-id,Values=${GROUP_ID}" \
        --output json
done
