import json
import botocore
import boto3

from sigv4a_sign import SigV4ASign


def lambda_handler(event, context):
    # TODO implement
    service = event['service']
    region = event['region']
    method = event['method']
    url = event['url']
    headers = event['headers']
    params = event['params']
    data = event['data']

    request_config = {
    'method': method.upper(),
    'url': url,
    'headers': headers,
    'params': params,
    'data': json.dumps(data)
    }

    headers = SigV4ASign().get_headers(service, region, request_config)
    
    tf_headers = {}
    
    for x in headers:
        tf_headers.update({x: headers[x]})
    
    return {
        'statusCode': 200,
        'headers': tf_headers,
        'data': request_config['data'],
        'request_params': request_config['params']
    }
