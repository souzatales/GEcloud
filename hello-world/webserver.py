import requests
import json
import os


def lambda_handler(event, context):

    url = 'https://rapidpro.ilhasoft.mobi/api/v2/flow_starts.json'
    
    headers = {
        'Authorization': f'Token {os.environ['auth_token']}',  # Substitua SEU_TOKEN_AQUI pelo seu token
        'Content-Type': 'application/json',
    }
    data = {
        "flow": "75d66485-de91-40e1-bbd0-b0ce1fffc787",
        "urns": ["whatsapp:558299805910"]
    }

    response = requests.post(url, headers=headers, data=json.dumps(data))

    # Verifique a resposta
    print(response.status_code)
    print(response.json())