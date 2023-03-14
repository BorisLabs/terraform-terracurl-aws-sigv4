import json
import botocore
import boto3

from lib.sigv4a_sign import SigV4ASign


def lambda_handler(event, context):
    return process_config(event)


def process_config(config):
    service = config.get('service', '')
    url = config.get('url', '')
    region = config.get('region', '')
    method = config.get('method', '')
    headers = config.get('headers', {})
    params = config.get('params', {})
    data = config.get('data', {})

    request_config = {
        'method': method.upper(),
        'url': url,
        'headers': headers,
        'params': params,
        'data': json.dumps(data)
    }

    headers = SigV4ASign().get_headers(service, region, request_config)

    tf_headers = {}

    for header in headers:
        tf_headers.update({header: headers[header]})

    return {
        'statusCode': 200,
        'headers': tf_headers,
        'data': request_config['data'],
        'request_params': request_config['params']
    }
