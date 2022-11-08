#!/bin/bash

# This works with Cloudformation

echo "Do you have AWS cli installed, configured also jq? yes/no"

read cli

if [ $cli = "yes" ];
then
   echo "Please provide the stack name."
   read stack

   echo "Please provide a bucket name, it should be dns compliant and unique."
   read bucket

   aws cloudformation create-stack --stack-name $stack --template-body file://template_cfn.yml --parameters ParameterKey=BucketName,ParameterValue=$bucket --capabilities CAPABILITY_AUTO_EXPAND
   while true;
   do
      status=$(aws cloudformation describe-stacks | jq -c --arg STACK "$stack" '.Stacks | .[] | select( .StackName == $STACK )' | jq -r .StackStatus)
      echo $status
      if [ $status = "CREATE_COMPLETE" ];
      then
        echo "uploading objects..."
        aws s3 cp ./assets/index.html s3://$bucket/index.html
        aws s3 cp ./assets/index.js s3://$bucket/index.js
        aws s3 cp ./assets/style.css s3://$bucket/style.css
        break
      elif [ $status = "CREATE_IN_PROGRESS" ]
      then
        echo 'Still creating...'
        continue
      else
         echo "Ouups! $status"
        break
      fi
   done
else
   echo "Please install AWS cli and configure it with the right permission to deploy an s3 bucket and a cloudfront distrobution or install jq"
fi

