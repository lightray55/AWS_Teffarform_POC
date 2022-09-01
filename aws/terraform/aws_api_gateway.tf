resource "aws_apigatewayv2_api" "lambda_gateway" {
  name          = "lambda_gateway"
  protocol_type = "HTTP"
}

resource "aws_apigatewayv2_stage" "lambda_stage" {
  api_id = aws_apigatewayv2_api.lambda_gateway.id

  name        = "lambda_stage"
  auto_deploy = true

  access_log_settings {
    destination_arn = aws_cloudwatch_log_group.api_log_group.arn

    format = jsonencode({
      requestId               = "$context.requestId"
      sourceIp                = "$context.identity.sourceIp"
      requestTime             = "$context.requestTime"
      protocol                = "$context.protocol"
      httpMethod              = "$context.httpMethod"
      resourcePath            = "$context.resourcePath"
      routeKey                = "$context.routeKey"
      status                  = "$context.status"
      responseLength          = "$context.responseLength"
      integrationErrorMessage = "$context.integrationErrorMessage"
      }
    )
  }
}

resource "aws_apigatewayv2_integration" "create" {
  api_id = aws_apigatewayv2_api.lambda_gateway.id

  integration_uri    = aws_lambda_function.create-incident.invoke_arn
  integration_type   = "AWS_PROXY"
  integration_method = "POST"
}

resource "aws_apigatewayv2_route" "create" {
  api_id = aws_apigatewayv2_api.lambda_gateway.id

  route_key = "POST /create"
  target    = "integrations/${aws_apigatewayv2_integration.create.id}"
}

resource "aws_cloudwatch_log_group" "api_log_group" {
  name = "/aws/api_gw/${aws_apigatewayv2_api.lambda_gateway.name}"

  retention_in_days = 7
}

resource "aws_lambda_permission" "api_permission" {
  statement_id  = "AllowExecutionFromAPIGateway"
  action        = "lambda:InvokeFunction"
  function_name = aws_lambda_function.create-incident.function_name
  principal     = "apigateway.amazonaws.com"

  source_arn = "${aws_apigatewayv2_api.lambda_gateway.execution_arn}/*/*"
}