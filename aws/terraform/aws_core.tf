locals {
  local_data = jsondecode(file(".env"))
}

provider "aws" {
  access_key = local.local_data.access_key
  secret_key = local.local_data.secret_key
  region     = "ap-southeast-2"
}