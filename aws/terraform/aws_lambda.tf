data "archive_file" "create-incident-archive" {
 source_file = "nodejs/backend/index.js"
 output_path = "nodejs/backend/index.zip"
 type = "zip"
}

resource "aws_lambda_function" "create-incident" {
 //I have hardcoded this in the file so don't need to add an environment variable... yet
 //environment {
 //  variables = {
 //    NOTES_TABLE = aws_dynamodb_table.tf_notes_table.name
 //  }
 //}
 memory_size = "128"
 timeout = 10
 runtime = "nodejs14.x"
 architectures = ["arm64"]
 handler = "index.handler"
 function_name = "create-incident"
 role = aws_iam_role.iam_for_lambda.arn
 filename = "nodejs/backend/index.zip"
 publish = false
 source_code_hash = filebase64sha256("nodejs/backend/index.zip")
}