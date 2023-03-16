import json

import boto3
import botocore
from botocore import crt, awsrequest


def lambda_handler(event, context):
    details = {}

    boto3_version = details.update({'Boto3': boto3.__version__})
    botocore_version = details.update({'Botocore': botocore.__version__})

    if 'auth' in dir(crt):
        details.update({'Auth': True})
    else:
        details.update({'Auth': False})

    return {
        'statusCode': 200,
        'Versions': json.dumps(details)
    }
