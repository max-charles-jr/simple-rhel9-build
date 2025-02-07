import boto3

def lambda_handler(event, context):
    ec2 = boto3.client('ec2')
    instance_id = 'i-0962aa5f0278d4086' # Replace with your EC2 instance ID
    ec2.stop_instances(InstanceIds=[instance_id])
    return {
        'statusCode': 200,
        'body': 'Instance stopped successfully'
    }