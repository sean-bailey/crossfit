"""kb4sre exercise"""
import os
import json
import boto3
import requests

# this is basically '/aws/lambda/<function name>'
LOG_GROUP_NAME = os.getenv('AWS_LAMBDA_LOG_GROUP_NAME')


def lambda_handler(event, context):
    """
    kb4sre exercise lambda handler
    Gets your current IP and the size of the log group as a hex string
    and prints them out in json
    """
    response = requests.get('https://icanhazip.com')
    ip = response.text.strip('\n')
    print(ip)
    client = boto3.client(
        'logs', region_name=os.getenv('AWS_REGION', 'us-east-1'))
    response = client.describe_log_groups(logGroupNamePrefix=LOG_GROUP_NAME)
    print(response)
    list_of_selected_log_group_size_in_bytes = [
        log_group['storedBytes'] for log_group in response['logGroups'] if log_group['logGroupName'] == LOG_GROUP_NAME]
    data = {
        'ip': ip,
        'log_group_size': hex((list_of_selected_log_group_size_in_bytes[0]) / 1024)
    }
    # int has no attribute hex
    return json.dumps(data)


if __name__ == "__main__":
    data = lambda_handler(None, None)
    print(data)
