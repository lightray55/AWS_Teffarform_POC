output "base_url" {
  description = "Base URL for API Gateway stage."
  value = aws_apigatewayv2_stage.lambda_stage.invoke_url
}

output "website_url" {
  description = "URL of the frontend website"
  value = aws_s3_bucket.b1.website_endpoint
}