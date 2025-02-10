import boto3
import os
import json

# Get environment variables
instance_id = os.environ['INSTANCE_ID']  # Replace with your EC2 instance ID
region = os.environ['REGION']  # Replace with your AWS region

def lambda_handler(event, context):
    # Initialize the EC2 client
    ec2 = boto3.client('ec2', region_name=region)

    # Describe the instance to check its current state
    try:
        instance_info = ec2.describe_instances(InstanceIds=[instance_id])
        instance_state = instance_info['Reservations'][0]['Instances'][0]['State']['Name']
    except Exception as e:
        return {
            'statusCode': 400,
            'body': json.dumps(f"Error describing instance: {str(e)}")
        }

    # Check if the instance is running
    if instance_state == 'running':
        # Stop the instance if it is running
        try:
            ec2.stop_instances(InstanceIds=[instance_id])
            response = f"Successfully stopped instance: {instance_id}"
            return {
                'statusCode': 200,
                'body': json.dumps(response)
            }
        except Exception as e:
            return {
                'statusCode': 400,
                'body': json.dumps(f"Error stopping instance: {str(e)}")
            }
    else:
        # If the instance is not running, return a message
        response = f"Instance {instance_id} is already off. Current state: {instance_state}. No further action needed."
        return {
            'statusCode': 200,
            'body': json.dumps(response)
        }