terraform {
    backend "s3" {
        bucket = "practicemodulestatefile"
        key    = "terraform_module/terraform.tfstate"
        use_lockfile = true
        region = "us-east-1"
    }
}
