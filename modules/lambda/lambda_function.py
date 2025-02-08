import boto3
import os

def lambda_handler(event, context):
    ec2 = boto3.client('ec2')
    instance_id = os.environ['INSTANCE_ID'] # Replace with your EC2 instance ID
    ec2.stop_instances(InstanceIds=[instance_id])
    return {
        'statusCode': 200,
        'body': 'Instance stopped successfully'
    }