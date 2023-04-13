import json
import botocore
import boto3

from lib.sigv4a_sign import SigV4ASign


def lambda_handler(event, context):
    sigv4_resp = {}

    for lifecycle_event in event.keys():
        print("Lifecycle event config")
        print(event[lifecycle_event])

        sigv4_resp.update(
            {lifecycle_event: process_config(event[lifecycle_event])})

    return sigv4_resp


def process_config(config):
    if config.get('config') == None:
        config_items = {}
    else:
       config_items = config.get('config')

    # Remove any None elements in the config
    config_items = {k: v for k, v in config_items.items() if v != None}

    service = config.get('service', '')
    url = config.get('url', '')
    region = config.get('region', '')

    method = config_items.get('method', '')
    headers = config_items.get('headers', {})
    params = config_items.get('params', {})
    data = config_items.get('data', {})

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
