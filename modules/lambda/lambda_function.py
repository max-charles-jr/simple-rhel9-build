import boto3
import os
import json

instance_ids = os.environ['INSTANCE_ID'] # Replace with your EC2 instance ID
region = os.environ['REGION'] # Replace with your AWS region

def lambda_handler(event, context):
    ec2 = boto3.client('ec2', region_name=region)
    ec2.stop_instances(InstanceIds=[instance_ids])
    response = "Successfully stopped instances: " + str(instance_ids)
    return {
        'statusCode': 200,
        'body': json.dumps(response)
    }