import requests

headers = {'Authorization': 'Bearer PLACE_JWT_HERE'}
req_response = requests.get('https://api-eus.qrypt.com/api/v1/quantum-entropy',
                            headers=headers)
response_json = req_response.json()
# array of random
print(response_json['random'])
