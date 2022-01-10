const https = require('https')
const options = {
  hostname: 'api-eus.qrypt.com',
  port: 443,
  path: '/api/v1/quantum-entropy',
  headers: {
	  'Authorization': 'Bearer PLACE_JWT_HERE'
  },
  method: 'GET'
}

const req = https.request(options, res => {
  console.log(`statusCode: ${res.statusCode}`)
  let all_chunks = [];

  res.on('data', (chunk) => {
    all_chunks.push(chunk);
  })

  res.on('end', () => {
    try {
      let response_body = Buffer.concat(all_chunks)
      let json_body = JSON.parse(response_body);
      // array of random
      console.log(json_body.random)
    } catch(error) {
      console.error(error)
    }
  })

})

req.on('error', error => {
  console.error(error)
})

req.end()
