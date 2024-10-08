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
        "flow": "904f3f94-5a21-41cc-a8d3-f21a69b71311",
        "urns": ["whatsapp:558299805910"]
    }

    response = requests.post(url, headers=headers, data=json.dumps(data))

    # Verifique a resposta
    print(response.status_code)
    print(response.json())

    return {
        'statusCode': 200,
        'body': json.dumps('Parâmetros recebidos com sucesso!')
    }