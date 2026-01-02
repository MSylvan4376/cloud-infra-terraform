terraform {
  backend "s3" {
    bucket         = "msylvan-terraform-state"            # your bucket name
    key            = "cloud-infra-terraform/terraform.tfstate"
    region         = "us-west-2"
    dynamodb_table = "terraform-locks"
    encrypt        = true
  }
}

