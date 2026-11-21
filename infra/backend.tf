terraform {
  # Bucket is created by platform-infra/bootstrap. Backend blocks cannot use variables.
  # Key is per service: user-service owns exactly this state and nothing else.
  backend "s3" {
    bucket       = "walterdmt88-taskmanager-tfstate-102301143105-apse1"
    key          = "user-service/infra.tfstate"
    region       = "ap-southeast-1"
    encrypt      = true
    use_lockfile = true
  }
}
