terraform {
  backend "s3" {
    bucket = "kthamel-jenkins-infrastructure"
    key    = "demo-vpc-tfstate"
    region = "us-east-1"
  }
}