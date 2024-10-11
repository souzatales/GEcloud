import requests
import json
import os
import json
# from urllib.parse import urlparse, parse_qs

def turn(uuid, phone):

    url = 'https://rapidpro.ilhasoft.mobi/api/v2/flow_starts.json'
    
    headers = {
        'Authorization': f'Token {os.environ['auth_token']}',  # Substitua SEU_TOKEN_AQUI pelo seu token
        'Content-Type': 'application/json',
    }
    data = {
        "flow": uuid,
        "urns": [f'whatsapp:{phone}']
    }

    response = requests.post(url, headers=headers, data=json.dumps(data))

    # Debug only
    print(response.status_code)
    print(response.json())

    if(response.status_code == 201):
        return True
    return False


def lambda_handler(event, context):
    # Extract the request context
    print(f'output: {event}')
    
    params_dict = event.get('queryStringParameters', {})
    
    response_body = {
            "query_parameters": event
        }
    
    try:
        uuid = params_dict['flow']
        phone = params_dict['urn']

        if(turn(uuid, phone)):
            return {
                'statusCode': 200,
                'body': json.dumps(response_body),
                'headers': {
                    'Content-Type': 'application/json'
                }
            }
    except KeyError:
        
        return {
                'statusCode': 400,
                'body': json.dumps(response_body),
                'headers': {
                    'Content-Type': 'application/json'
                }
            }