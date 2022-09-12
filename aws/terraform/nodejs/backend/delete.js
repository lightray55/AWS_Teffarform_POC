const AWS = require("aws-sdk"); // using the SDK
const INCIDENT_TABLE = "tf-incident-table"; // obtaining the table name

const documentClient = new AWS.DynamoDB.DocumentClient();

module.exports.handler = async (event, context) => {
    //check incidentId is specified 
    var jsonBody = event.body
    if(event.body.constructor == String) {
      jsonBody = JSON.parse(event.body)
    }
    if(jsonBody.hasOwnProperty('incidentId')) {
        

        const id = jsonBody.incidentId;
        await documentClient
          .delete({
            TableName: INCIDENT_TABLE,
            Key: {
              incidentId: id,
            },
          }).promise();
             
        return {
          statusCode: 200,
          body: JSON.stringify({ message: "Item Deleted" }),
          headers: {
            'Access-Control-Allow-Origin' : '*'
          }
        }
    } else {
        // if password is incorrect - return error
        return {statusCode: 500,body: '{"error":"Invalid Request"}',
          headers : {
            'Access-Control-Allow-Origin' : '*'
          }
        } 
    }
};