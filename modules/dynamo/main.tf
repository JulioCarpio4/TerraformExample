resource "aws_dynamodb_table" "dynamodb-table-JC" {
  name           = "People"
  billing_mode   = "PAY_PER_REQUEST"
  read_capacity  = 20
  write_capacity = 20
  hash_key       = "userId"
  range_key      = "Country"

  attribute {
    name = "userId"
    type = "S"
  }

  attribute {
    name = "Country"
    type = "S"
  }
  
  tags = {
    Name        = "dynamodb-table-JC"
    Environment = "production"
  }
}