const util = require('util');
const create = require('../create');
const AWS = require('../__mocks__/aws-sdk');

const documentClient = new AWS.DynamoDB.DocumentClient();

const goodEvent = { "body": 
    {
        "password": "MattAndDansSuperSecretPassword",
        "eventLocation":"Grand Hall",
        "eventType":"Negative",
        "numParticipants":"2"
    }  
}

test('Saved data should include expiryPeriod and incidentId', async () => {
    const create_return = await create.handler(goodEvent,"fakeContext");
    //console.log(util.inspect(create_return, false, null, false));
    const create_return_body = JSON.parse(create_return.body);
    expect(documentClient.put).toHaveBeenCalled();
    expect(create_return_body).toHaveProperty('expiryPeriod');
    expect(create_return_body).toHaveProperty('incidentId');
});