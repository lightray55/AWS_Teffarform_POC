const util = require('util') // Useful functions
const AWS = require("aws-sdk"); // using the SDK
const INCIDENT_TABLE = "tf-incident-table"; // obtaining the table name

const documentClient = new AWS.DynamoDB.DocumentClient();

module.exports.handler = async (event, context) => {
    var jsonBody = event.body
    if(event.body.constructor == String) {
      jsonBody = JSON.parse(event.body)
    }
    if(jsonBody.hasOwnProperty('numberToGet')) {
        const num = jsonBody.numberToGet;
        const params = {
            TableName:INCIDENT_TABLE,
            Limit: num
        }
        try{
            var data  = await documentClient.scan(params, function(err, data){
                if (err) console.log(err);
                else return data//console.log(data);
                
            }).promise();

            //console.log("Success :", util.inspect(documentClient, false, null, false));
            // console.log("Success :", data.Item);
            return {statusCode: 200,body: '{"success":"true"}',
                headers : {
                  'Access-Control-Allow-Origin' : '*'
                }
              };;
        } catch (err) {
            console.log("Error", err)
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
    