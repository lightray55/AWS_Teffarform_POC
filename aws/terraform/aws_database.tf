resource "aws_dynamodb_table" "tf_incident_db" {
  name = "tf-incident-table"

  // The free tier comes with 25 units of read and write capacity. 2 should be well below this.
  billing_mode = "PROVISIONED"
  read_capacity= "2"
  write_capacity= "2"

  //Only primary keys and indexes need to be defined at the table level
  attribute {
    name = "incidentId"
    type = "S"
  }
  hash_key = "incidentId"

  //We don't need to back things up - yet
  point_in_time_recovery {
    enabled = false
  }

  // configure encryption at REST
  server_side_encryption {
    enabled = false
  }

  //Automatic deletion of table entries based on expiryDate, a linux expoch time number
  ttl {
    enabled = true 
    attribute_name = "expiryDate" 
  }
}