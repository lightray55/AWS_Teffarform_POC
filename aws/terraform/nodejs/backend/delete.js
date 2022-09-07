const AWS = require("aws-sdk"); // using the SDK
const INCIDENT_TABLE = "tf-incident-table"; // obtaining the table name

const documentClient = new AWS.DynamoDB.DocumentClient();

module.exports.handler = async (event, context) => {
    //check incidentId is specified 
    if(event.body.hasOwnProperty('incidentId')) {
        const id = event.body.incidentId;
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