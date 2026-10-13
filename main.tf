
provider "aws" {
  region = "us-east-2"
}
module "logs" {
  source             = "./modules/s3_bucket"
  bucket_name        = "myname-logs-bucket-123"
  versioning_enabled = true 
  tags               = { purpose = "log" }
}

module "assets" {
  source             = "./modules/s3_bucket"
  bucket_name        = "myname-assets-bucket-123"
  versioning_enabled = false
  tags               = { purpose = "assets" }
}

