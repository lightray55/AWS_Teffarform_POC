data "archive_file" "delete_incident_archive" {
 source_file = "nodejs/backend/delete.js"
 output_path = "nodejs/backend/delete.zip"
 type = "zip"
}

resource "aws_lambda_function" "delete_incident" {
 memory_size = "128"
 timeout = 10
 runtime = "nodejs14.x"
 architectures = ["arm64"]
 handler = "delete.handler"
 function_name = "delete_incident"
 role = aws_iam_role.iam_for_lambda.arn
 filename = "nodejs/backend/delete.zip"
 source_code_hash = filebase64sha256("nodejs/backend/delete.zip")
}

data "archive_file" "create_incident_archive" {
 source_file = "nodejs/backend/create.js"
 output_path = "nodejs/backend/create.zip"
 type = "zip"
}

resource "aws_lambda_function" "create_incident" {
 memory_size = "128"
 timeout = 10
 runtime = "nodejs14.x"
 architectures = ["arm64"]
 handler = "create.handler"
 function_name = "create_incident"
 role = aws_iam_role.iam_for_lambda.arn
 filename = "nodejs/backend/create.zip"
 publish = false
 source_code_hash = filebase64sha256("nodejs/backend/create.zip")
}