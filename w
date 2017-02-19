#!/usr/local/bin/bash
###################dd#########################################################
# Retrieves Project ID value from EC2 Instance
##############################################################################
get-project-id() {
  aws ec2 describe-tags \
    --filters "Name=key,Values=Project" "Name=key,Values=Environment" \
	  --profile $1 \
	  --output text 
# | awk '{print $5}' | head -n1
}

###################dd#########################################################
# Displays the most current Intuit AMI ID. Region is specified as argument
###############################################################################
get-current-intuit-ami() {
  if [ -z "$1" ]; then
    echo "Please specify the desired AWS region: ex us-west-2"
    echo "Usage: latest_ami us-west-2"
    return 1
  fi

  distro="rhel7.2"
  ami_raw=$(curl -s "https://hosting.intuit.com/amiquery/amis?tag=osVersion:$distro&tag=virtualization:hvm&status=available&tag=relatedTechnology:linux&region=$1") 2>/dev/null
  ami_id=$(echo "$ami_raw" | jq -r 'max_by(.tags.creationDate).id')
  echo $region": "$ami_id
}


va-cluster-details() {
  [  -z $1 ] && echo "Error: Missing Argument - Usage: va-cluster-details [playground, pre-prod or prod]"
  
  case $1 in
	  "playground") PLAYGROUND=$1;;
	  "pre-prod") PRE-PRODUCTION=$1;;
	  "prod") PRODUCTION=$1;;
	  *) echo "Sorry, $1 is not a viable environment.";;
  esac

  aws ec2 describe-instances --output table --query 'Reservations[*].{AWS:OwnerId,region:Instances[0].Placement.AvailabilityZone, NAME:Instance[0].Tags[?Key==`Name`] | [0].Value, InstanceID:Instances[0].InstanceId}' --filters 'Name=tag:Name,Values=VA*' 'Name=tag:Environment,Values='$1

  aws ec2 describe-instances --output table --query 'Reservations[0].{ENDPOINT:Instances[0].Tags[?Key==`Project-Endpoint`]|[0].Value, SERIAL:Instances[0].Tags[?Key==`Project`]|[0].Value}' --filters 'Name=tag:Environment,Values='$1 
}
