const AWS = require("aws-sdk"); // using the SDK
const INCIDENT_TABLE = "tf-incident-table"; // obtaining the table name

const documentClient = new AWS.DynamoDB.DocumentClient();

module.exports.handler = async (event, context) => {

  // check that the password is correct
  if(event.hasOwnProperty('body') && event.body.hasOwnProperty('password') && event.body.password == "MattAndDansSuperSecretPassword") {

    // create a new object
    expiryDate = Date.now() + 604800000; //This magic number is 7 days in milliseconds
    
    var newIncident = {
      ...event.body,
      incidentId: Date.now().toString(),
      expiryPeriod: expiryDate, // specify TTL
    };

    //remove the password from the object so we don't store it in the database
    delete newIncident.password

    // insert the new incident into the table
    await documentClient
    .put({
        TableName: INCIDENT_TABLE,
        Item: newIncident,
        })
    .promise();
        
    // return the created object
    return {statusCode: 200,body: JSON.stringify(newIncident), 
    };
  } else {
    // if password is incorrect - return error
    return {statusCode: 500,body: '{"error":"Invalid Request"}'} 
  }
};